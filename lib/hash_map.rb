# frozen_string_literal: true

require_relative 'linked_lists'

# This houses the methods of a hash map
class HashMap
  def initialize
    @capacity = 4
    @load_factor = 0.75
    @buckets = Array.new(@capacity)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code % @buckets.size
  end

  def set(key, value)
    if buckets_length(@buckets) >= @capacity * @load_factor
      current_entries = entries
      @capacity += 4
      @buckets = Array.new(@capacity)
      current_entries.each do |entry|
        add_to_bucket(entry[0], entry[1])
      end
    end
      
    add_to_bucket(key, value)
  end

  def get(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    return nil if @buckets[index] == nil || !has(key)
    
    current_node = find_node(key, @buckets[index])
    current_node.value[1]
  end

  def has(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    return false if @buckets[index] == nil
    
    current_node = find_node(key, @buckets[index])
    current_node.value[0] == key
  end

  def remove(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    return nil if @buckets[index] == nil || !has(key)
    
    current_node = find_node(key, @buckets[index])
    @buckets[index].remove_at(@buckets[index].find(current_node.value)) if has(key)
    return current_node
  end

  def length
    count = 0

    @buckets.each do |item|
      count += item.size unless item.nil?
    end
   
    count
  end

  def clear
    @buckets.clear
    @capacity = 4
    @buckets = Array.new(@capacity)
  end

  def keys
    keys = []

    @buckets.each do |item|
      next if item.nil? || item.head.nil?

      current_node = item.head

      until current_node.next_node.nil?
        keys.push(current_node.value[0])
        current_node = current_node.next_node
      end

      keys.push(current_node.value[0])
    end
   
    keys
  end

  def values
    values = []

    @buckets.each do |item|
      next if item.nil? || item.head.nil?

      current_node = item.head
    
      until current_node.next_node.nil?
        values.push(current_node.value[1])
        current_node = current_node.next_node
      end

      values.push(current_node.value[1])
    end
   
    values
  end

  def entries
    entries = []

    @buckets.each do |item|
      next if item.nil? || item.head.nil?

      current_node = item.head
    
      until current_node.next_node.nil?
        entries.push(current_node.value)
        current_node = current_node.next_node
      end

      entries.push(current_node.value)
    end
   
    entries
  end

  private

  def add_to_bucket(key, value)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    if @buckets[index] == nil
      linked_list = LinkedList.new 
      linked_list.append([key, value])
      @buckets[index] = linked_list
    elsif has(key)
      current_node = find_node(key, @buckets[index])
      current_node.value[1] = value
    else
      @buckets[index].append([key, value])
    end
  end

  def buckets_length(buckets)
    length = buckets.length
    buckets.each { |item| length -= 1 if item.nil? }
    length
  end

  def find_node(key, linked_list)
    current_node = linked_list.head
    
    until current_node.next_node.nil?
      break if current_node.value[0] == key
      current_node = current_node.next_node
    end
    
    current_node
  end 
end

hash_map = HashMap.new

hash_map.set('Carlos', 'Alvarez')
hash_map.set('Carla', 'Gomez')
hash_map.set('Chinh', 'Le')
hash_map.set('Juan', 'Soto')
hash_map.set('Pedro', 'Martinez')
hash_map.set('Albert', 'Pujols')
hash_map.set('Hideki', 'Matsui')
hash_map.set('Hideo', 'Nomo')
hash_map.set('Rickey', 'Henderson')
hash_map.set('Rickey', 'Martin')

p hash_map.remove('Carla')

p hash_map
p hash_map.length
p hash_map.values
p hash_map.entries
p hash_map.clear
p hash_map

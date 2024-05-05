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
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length
    if @buckets[index] == nil
      linked_list = LinkedList.new 
      linked_list.append({"#{key}": value})
      @buckets[index] = linked_list
    elsif has(key)
      current_node = @buckets[index].head
    
      until current_node.next_node.nil?
        break if current_node.value.key?(key.to_sym)
        current_node = current_node.next_node
      end

      current_node.value[key.to_sym] = value
    else
      @buckets[index].append({"#{key}": value})
    end
  end

  def get(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    return nil if @buckets[index] == nil
    
    current_node = @buckets[index].head
    
    until current_node.next_node.nil?
      break if current_node.value.key?(key.to_sym)

      current_node = current_node.next_node
    end

    current_node.value[key.to_sym]
  end

  def has(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    return false if @buckets[index] == nil
    
    current_node = @buckets[index].head
    
    until current_node.next_node.nil?
      break if current_node.value.key?(key.to_sym)

      current_node = current_node.next_node
    end
    
    current_node.value.key?(key.to_sym)
  end

  def remove(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    return nil if @buckets[index] == nil
    
    current_node = @buckets[index].head
    
    until current_node.next_node.nil?
      if current_node.value.key?(key.to_sym)
        @buckets[index].remove_at(@buckets[index].find(current_node.value))
        return current_node
      else  
        current_node = current_node.next_node
      end
    end
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
      next if item.nil?

      current_node = item.head
    
      until current_node.next_node.nil?
        keys.push(current_node.value.keys)
        current_node = current_node.next_node
      end

      keys.push(current_node.value.keys)
    end
   
    keys.flatten
  end

  def values
    values = []

    @buckets.each do |item|
      next if item.nil?

      current_node = item.head
    
      until current_node.next_node.nil?
        values.push(current_node.value.values)
        current_node = current_node.next_node
      end

      values.push(current_node.value.values)
    end
   
    values.flatten
  end

  def entries
    entries = []

    @buckets.each do |item|
      next if item.nil?

      current_node = item.head
    
      until current_node.next_node.nil?
        entries.push([current_node.value.keys, current_node.value.values].flatten)
        current_node = current_node.next_node
      end

      entries.push([current_node.value.keys, current_node.value.values].flatten)
    end
   
    entries
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
hash_map.set('Rickey', 'Henderson')
hash_map.set('Rickey', 'Martin')

p hash_map
p hash_map.keys
p hash_map.entries

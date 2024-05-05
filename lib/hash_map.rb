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
      return current_node.value.key?(key.to_sym) if current_node.value.key?(key.to_sym)

      current_node = current_node.next_node
    end
    false
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

    nil
  end
end

hash_map = HashMap.new

hash_map.set('Carlos', 'Alvarez')
hash_map.set('Carla', 'Gomez')
hash_map.set('Chinh', 'Le')
hash_map.set('Juan', 'Soto')
hash_map.set('Pedro', 'Martinez')
hash_map.set('Albert', 'Pujols')

p hash_map
p hash_map.remove('Carlos')
p hash_map.has('Carlos')

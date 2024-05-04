# frozen_string_literal: true

require_relative 'linked_lists'

# This houses the methods of a hash map
class HashMap
  def initialize
    @buckets = Array.new(16)
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
    
    until current_node.value.key?(key.to_sym)
      current_node = current_node.next_node
    end

    current_node.value[key.to_sym]
  end
end

hash_map = HashMap.new

hash_map.set('Carlos', 'Alvarez')
hash_map.set('Carla', 'Gomez')

p hash_map
p hash_map.get('Carla')

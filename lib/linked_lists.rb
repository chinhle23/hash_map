# frozen_string_literal: true

# This houses the methods of a linked list
class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  def append(value)
    node = Node.new(value)

    if @head.nil?
      @head = node
    else
      current_node = @head

      current_node = current_node.next_node until current_node.next_node.nil?

      current_node.next_node = node
    end
  end

  def prepend(value)
    node = Node.new(value)
    node.next_node = @head unless @head.nil?
    @head = node
  end

  def size
    return 0 if @head.nil?

    count = 1
    current_node = @head

    until current_node.next_node.nil?
      current_node = current_node.next_node
      count += 1
    end

    count
  end

  def tail
    return nil if @head.nil?

    current_node = @head

    current_node = current_node.next_node until current_node.next_node.nil?

    current_node
  end

  def at(index)
    return nil if @head.nil? || (index + size).negative? || index + 1 > size

    current_node = @head
    index += size if index.negative?
    index.times { current_node = current_node.next_node }

    current_node
  end

  def pop
    return nil if @head.nil?

    tail = self.tail

    if size == 1
      @head = nil
    else
      current_node = @head
      (size - 2).times { current_node = current_node.next_node }
      current_node.next_node = nil
    end

    tail
  end

  def contains?(value)
    return false if @head.nil?

    current_node = @head
    return true if current_node.value == value

    until current_node.next_node.nil?
      current_node = current_node.next_node
      return true if current_node.value == value
    end

    false
  end

  def find(value)
    return nil if @head.nil?

    index = 1
    current_node = @head
    return 0 if current_node.value == value

    until current_node.next_node.nil?
      current_node = current_node.next_node
      return index if current_node.value == value

      index += 1
    end
  end

  def to_s
    return 'nil' if @head.nil?

    linked_list_str = String.new
    current_node = @head
    linked_list_str.concat("( #{current_node.value} ) -> ")

    until current_node.next_node.nil?
      current_node = current_node.next_node
      linked_list_str.concat("( #{current_node.value} ) -> ")
    end

    linked_list_str.concat(' nil')
  end

  def insert_at(value, index)
    node = Node.new(value)

    if @head.nil? || index.zero? || index + size <= 0
      prepend(value)
    elsif index + 1 > size
      append(value)
    else
      index += size if index.negative?
      prior_node = @head
      (index - 1).times { prior_node = prior_node.next_node }
      after_node = prior_node.next_node
      prior_node.next_node = node
      node.next_node = after_node
    end
  end

  def remove_at(index)
    return nil if @head.nil? || (index + size).negative? || index + 1 > size

    if index.zero? || index + size <= 0
      removed_node = @head
      @head = @head.next_node
    else
      index += size if index.negative?
      current_node = @head
      (index - 1).times { current_node = current_node.next_node }
      removed_node = current_node.next_node
      current_node.next_node = current_node.next_node.next_node
    end

    removed_node
  end
end

# The node objects that make up a linked list
class Node
  attr_accessor :value, :next_node

  def initialize(value)
    @value = value
    @next_node = nil
  end
end

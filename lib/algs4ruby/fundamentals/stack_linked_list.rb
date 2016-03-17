module Algs4Ruby
  # StackLinkedList
  #
  # A Stack is a container that allows LIFO (last in, first out) access to its
  # contents.
  #
  # This implementation uses a singly linked list. Initializing a new stack
  # takes constant time. The #push, #pop, #peek, #size, #empty? operations
  # all take constant time as well. Enumerating over the items on the stack
  # takes time proportional to the number of items on the stack.
  #
  # The class includes Enumerable and all those operations also take time
  # proportional to the number of items on the stack.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # Testing client:
  #   ruby stack_linked_list.rb < file1 file2 file3
  #   ruby stack_linked_list.rb
  #
  # If given one or more files, it reads from the files. If not given any files
  # it reads from standard input.
  # If the line does not equal '-' it push the line to the stack'.
  # If the line does equal '-' it pops an item from the stack if possible and
  #   prints it to standard out.
  # Finally it prints the number of items remaining on the stack to standard
  #   out.
  #
  # @!attribute size [r] The number of items on the stack.
  #   Performance: constant time in the worst case.
  #   @return [Integer] the number of items on the stack.
  # @!attribute size [r] The number of items on the stack.
  #   Performance: constant time in the worst case.
  #   @return [Integer] the number of items on the stack.
  class StackLinkedList
    # A node for the singly-linked list
    # @api private
    StackNode = Struct.new(:item, :next_node)

    include Enumerable
    attr_reader :size
    alias length size

    # Initialize a new empty stack.
    # Performance: O(1) time and O(1) space.
    def initialize
      @first = nil
      @size = 0
    end

    # Push an item on to the stack.
    # Performance: O(1) time and O(1) space.
    # @param item [Object] the item to add.
    # @return [void]
    def push(item)
      @first = StackNode.new(item, @first)
      @size += 1
    end

    # Return the item most recently added to the stack and remove it from the
    # stack.
    # Performance: O(1) time and O(1) space.
    # @return [Object] the most recently added item.
    # @raise [StackEmptyError] if the stack is empty before the pop operation.
    def pop
      fail StackEmptyError if empty?

      item = @first.item
      @first = @first.next_node
      @size -= 1

      item
    end

    # Return the item most recently added to the stack, but do not remove it
    # from the stack.
    # Performance: O(1) time and O(1) space.
    # @return [Object] the most recently added item.
    # @raise [StackEmptyError] if the stack is empty before the peek operation.
    def peek
      fail StackEmptyError if empty?

      @first.item
    end

    # Is the stack empty?
    # Performance: O(1) time and O(1) space.
    # @return [Boolean] true if the stack is empty, false otherwise.
    def empty?
      @size == 0
    end

    # Enumerate over the items in the stack in LIFO (last in, first out)
    # order.
    # Performance: O(n) time and O(1) additional space.
    # @yield [Object] the items in the stack.
    # @return [Enumerator<:each>] an enumerator if no block is given.
    # @return [self] if a block is given.
    def each
      return enum_for :each unless block_given?

      current_node = @first
      @size.times do
        yield current_node.item
        current_node = current_node.next_node
      end

      self
    end
  end

  # Testing client
  #
  # Read lines from ARGF
  # If a line is not '-', put the item on the stack.
  # If a line IS '-', then pop an item from the stack if the stack is not empty
  #   and print that item to standard out.
  # Print the size of the stack.
  if __FILE__ == $PROGRAM_NAME
    stack = StackLinkedList.new
    ARGF.readlines.each do |l|
      if l.chomp == '-'
        puts(" #{stack.pop}") unless stack.empty?
      else
        stack.push(l.chomp)
      end
    end

    puts "(#{stack.size} item(s) left on the stack)"
  end
end

###############################################################################
# The code in this file is based on the java code in LinkedStack from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# stack_linked_list.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# stack_linked_list.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with stack_linked_list.rb. If not, see http://www.gnu.org/licenses.
################################################################################

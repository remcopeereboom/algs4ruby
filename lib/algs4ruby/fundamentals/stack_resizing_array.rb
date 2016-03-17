module Algs4Ruby
  # StackResizingArray
  #
  # A Stack is a container that allows LIFO (last in, first out) access to its
  # contents.
  #
  # This implementation uses a resizing array. Initializing a new stack
  # takes constant time. The #peek, #size, and #empty? operations
  # all take constant time as well, but the #push and #pop operations only take
  # amortized cost constant time. Enumerating over the items on the stack
  # takes time proportional to the number of items on the stack.
  #
  # The class includes Enumerable and all those operations also take time
  # linearly proportional to the number of items on the stack.
  #
  # Testing client:
  #   ruby stack_resizing_array.rb < file1 file2 file3
  #   ruby stack_resizing_array.rb
  #
  # If given one or more files, it reads from the files. If not given any files
  # it reads from standard input.
  # If the line does not equal '-' it push the line to the stack'.
  # If the line does equal '-' it pops an item from the stack if possible and
  #   prints it to standard out.
  # Finally it prints the number of items remaining on the stack to standard
  #   out.
  #
  # @!attribute size [r]
  #   Performance: O(1) worst case time and O(1) space.
  #   @return [Integer] the number of items on the stack.
  # @!attribute size [r] The number of items on the stack.
  #   Performance: O(1) worst case time and O(1) space.
  #   @return [Integer] the number of items on the stack.
  class StackResizingArray
    include Enumerable
    attr_reader :size
    alias length size

    # Initialize a new empty stack.
    # Performance: O(1) worst case time and O(1) space.
    def initialize
      @items = Array.new(2)
      @size = 0
    end

    # Push an item on to the stack.
    # Performance: O(1) amortized time and O(1) amortized space.
    # @param item [Object] the item to add.
    # @return [void]
    def push(item)
      resize(2 * capacity) if @size == capacity

      @items[@size] = item
      @size += 1
    end

    # Return the item most recently added to the stack and remove it from the
    # Performance: O(1) amortized time and O(1) amortized space.
    # stack.
    # @return [Object] the most recently added item.
    # @raise [StackEmptyError] if the stack is empty before the pop operation.
    def pop
      fail StackEmptyError if empty?

      item = @items[@size - 1]
      @items[@size - 1] = nil # Prevent loitering
      @size -= 1

      resize(capacity / 2) if @size != 0 && capacity / 4 >= @size
      item
    end

    # Return the item most recently added to the stack, but do not remove it
    # from the stack.
    # Performance: O(1) worst case time and O(1) space.
    # @return [Object] the most recently added item.
    # @raise [StackEmptyError] if the stack is empty before the peek operation.
    def peek
      fail StackEmptyError if empty?
      @items[@size - 1]
    end

    # Is the stack empty?
    # Performance: O(1) worst case time and O(1) space.
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

      @size.times { |i| yield @items[@size - i - 1] }

      self
    end

    private

    # The capacity of the items array.
    # Performance: O(1) worst case time and O(1) space.
    # @return [Integer]
    def capacity
      @items.size
    end

    # Resize the array
    # Performance: O(n) time and O(n) additional space.
    # @return [void]
    # @raise [ArgumentError] if the new capacity is insufficient to fit the
    #   items in the bag.
    def resize(new_cap)
      if new_cap < @size
        fail ArgumentError,
             "New capacity (#{new_cap}) must be > than array size (#{size})"
      end

      old = @items
      @items = Array.new(new_cap)
      @size.times { |i| @items[i] = old[i] }
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
    stack = StackResizingArray.new
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
# The code in this file is based on the java code in ResizingArrayStack from
# alg4.jar library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# stack_resizing_array.rb is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# stack_resizing_array.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with stack_resizing_array.rb. If not, see http://www.gnu.org/licenses.
################################################################################

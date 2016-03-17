module Algs4Ruby
  # QueueResizingArray
  #
  # A Queue is a container that allows FIFO (last in, first out)
  # access to its contents.
  #
  # This implementation uses a resizing array. Initializing a new queue
  # takes constant time in the worst case. The #peek, #size, and #empty?
  # operations all take constant time as well. The #enqueue and the #dequeue
  # operations take amortized constant time. Enumerating over the items in
  # the queue takes time proportional to the number of items on the queue.
  #
  # The class includes Enumerable and all those operations also take time
  # proportional to the number of items on the queue.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # testing client:
  #   ruby queue_resizing_array.rb < file1 file2 file3
  #   ruby queue_resizing_array.rb
  #
  # if given one or more files, it reads from the files. if not given any files
  # it reads from standard input.
  # if the line does not equal '-' it enqueues the line to the queue'.
  # if the line does equal '-' it dequeues an item from the queue if possible
  #   and prints it to standard out.
  # finally it prints the number of items remaining in the queue to standard
  #   out.
  #
  # @!attribute size [r] the number of items in the queue.
  #   Performance: O(1) time and O(1) space.
  #   @return [integer] the number of items in the queue.
  # @!attribute size [r] the number of items in the queue.
  #   Performance: O(1) time and O(1) space.
  #   @return [integer] the number of items in the queue.
  class QueueResizingArray
    include Enumerable
    attr_reader :size
    alias length size
 
    # Initialize a new empty queue.
    # Performance: O(1) worst case time and O(1) space.
    def initialize
      @items = Array.new(2)
      @first = 0
      @last = 0
      @size = 0
    end

    # Is the stack empty?
    # Performance: O(1) worst case time and O(1) space.
    # @return [Boolean] true if the stack is empty, false otherwise.
    def empty?
      @size == 0
    end

    # Add an item to the back of the queue.
    # Performance: O(1) amortized time and O(1) amortized space.
    # @param item [Object] the item to add.
    # @return [void]
    def enqueue(item)
      resize(2 * capacity) if capacity == @size

      @items[@last] = item
      @last += 1
      last = 0 if @last == @items.size # Wrap-around

      @size += 1
    end
    alias shift enqueue

    # Return an item from the front of the queue and remove it from the
    # queueu.
    # Performance: O(1) amortized time and O(1) amortized space.
    # @return [Object] the item least recently added to the queue.
    # @raise [QueueEmptyError] if the queue is empty.
    def dequeue
      fail QueueEmptyError if empty?

      item = @items[@first]
      @items[@first] = nil # Prevent loitering
      @first += 1

      @first = 0 if @first == @items.size # Wrap-around

      @size -= 1
      resize(capacity / 4) if @size !=0 && @size == capacity / 4

      item
    end
    alias unshift dequeue

    # Return an item from the front of the queue, but do not remove it from
    # the queue.
    # Performance: O(1) worst case time and O(1) space.
    # @return [Object] the item least recently added to the queue.
    # @raise [QueueEmptyError] if the queue is empty.
    def peek
      fail QueueEmptyError if empty?

      @items[@first]
    end

    # Enumerate over the items in the queue in FIFO (first in, first out) order.
    # Performance: O(n) worst case time and O(1) additional space.
    # @yield [Object] the items in the queue in FIFO order.
    # @return [Enumerator<:each>] if not given a block.
    # @return [self] if given a block.
    def each
      return enum_for :each unless block_given?

      if @first < @last
        @first.upto(@last - 1) { |i| yield @items[i] }
      else
        @first.upto(@items.size - 1) { |i| yield @items[i] }
        0.upto(@last - 1) { |i| yield @items[i] }
      end

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
    # Performance: O(n) worst case time and O(n) space.
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

      if @first < @last
        @first.upto(@last - 1) { |i| @items[i] = old[i] }
      else
        @first.upto(@items.size - 1) { |i| @items[i] = old[i] }
        0.upto(@last - 1) { |i| @items[i] = old[i] }
      end
    end
  end

  # Testing client
  #
  # Read lines from ARGF.
  # If a line is not '-', put the item in the queue.
  # If a line IS '-', then dequeue an item from the queue if the stack is not
  #   empty and print that item to standard out.
  # Print the size of the queue.
  if __FILE__ == $PROGRAM_NAME
    queue = QueueResizingArray.new
    ARGF.readlines.each do |l|
      if l.chomp == '-'
        puts(" #{queue.dequeue}") unless queue.empty?
      else
        queue.enqueue(l.chomp)
      end
    end

    puts "(#{queue.size} item(s) left in the queue)"
  end
end

###############################################################################
# The code in this file is based on the java code in QueueResizingArray from
# alg4.jar library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# queue_resizing_array.rb is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# queue_resizing_array.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with queue_resizing_array.rb. If not, see http://www.gnu.org/licenses.
################################################################################

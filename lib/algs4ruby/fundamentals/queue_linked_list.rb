module Algs4Ruby
  # QueueLinkedList
  #
  # A Queue is a container that allows FIFO (last in, first out) access to its
  # contents.
  #
  # This implementation uses a singly linked list. Initializing a new queue
  # takes constant time. The #enqueue, #dequeue, #peek, #size, and #empty?
  # operations all take constant time as well. Enumerating over the items in
  # the queue takes time proportional to the number of items on the queue.
  #
  # The class includes Enumerable and all those operations also take time
  # proportional to the number of items on the queue.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # testing client:
  #   ruby queue_linked_list.rb < file1 file2 file3
  #   ruby queue_linked_list.rb
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
  class QueueLinkedList
    # A node for the singly-linked list
    # @api private
    QueueNode = Struct.new(:item, :next_node)

    include Enumerable
    attr_reader :size
    alias length size

    # Initialize a new empty queue.
    # Performance: O(1) time and O(1) space.
    def initialize
      @first = nil
      @last = nil
      @size = 0
    end

    # Is this stack empty?
    # Performance: O(1) time and O(1) space.
    # @return [Boolean] true if empty, false otherwise.
    def empty?
      @size == 0
    end

    # Add an item to the back of the queue.
    # Performance: O(1) time and O(1) space.
    # @param item [Object] the item to add.
    # @return [void]
    def enqueue(item)
      old_last = @last
      @last = QueueNode.new(item, nil)

      if empty?
        @first = @last
      else
        old_last.next_node = @last
      end

      @size += 1
    end
    alias unshift enqueue

    # Return an item from the front of the queue and remove it from the
    # queueu.
    # Performance: O(1) time and O(1) space.
    # @return [Object] the item least recently added to the queue.
    # @raise [QueueEmptyError] if the queue is empty.
    def dequeue
      fail QueueEmptyError if empty?

      item = @first.item
      @first = @first.next_node
      @size -= 1
      @last = nil if empty? # Prevent loitering

      item
    end
    alias shift dequeue

    # Return an item from the front of the queue, but do not remove it from
    # the queue.
    # Performance: O(1) time and O(1) space.
    # @return [Object] the item least recently added to the queue.
    # @raise [QueueEmptyError] if the queue is empty.
    def peek
      fail QueueEmptyError if empty?

      @first.item
    end

    # Enumerate over the items in the queue in FIFO (first in, first out) order.
    # Performance: O(n) time and O(1) additional space.
    # @yield [Object] the items in the queue in FIFO order.
    # @return [Enumerator<:each>] if not given a block.
    # @return [self] if given a block.
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
  # Read lines from ARGF.
  # If a line is not '-', put the item in the queue.
  # If a line IS '-', then dequeue an item from the queue if the stack is not
  #   empty and print that item to standard out.
  # Print the size of the queue.
  if __FILE__ == $PROGRAM_NAME
    queue = QueueLinkedList.new
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
# The code in this file is based on the java code in LinkedQueue from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# queue_linked_list.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# queue_linked_list.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with queue_linked_list.rb. If not, see http://www.gnu.org/licenses.
################################################################################

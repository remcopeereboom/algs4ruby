module Algs4Ruby
  # BagLinkedList
  #
  # A multiset of generic items.
  # It supports insertaion and iteration over the items in arbitrary order.
  # This implementation is implemented with a linked list. As a result all
  # operations take constant time, except for iteration which takes time
  # proporional to the number of items in the bag.
  #
  # The class includes Enumerable and all those operations also take time
  # linearly proportional to the number of items in the bag.
  #
  # Includes Enumerable.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # Testing client:
  #   ruby bag.rb < file1 file2 file3
  #   ruby bag.rb
  #
  # If given one or more files, it reads from the files. If not given any files
  # it reads from standard input. Adds each line from the input as a string to
  # the bag. Finally, it prints out the size of the bag and the elements in the
  # bag.
  #
  #
  # Takes an integer n as a command-line argument and uses it to n times print
  # @!attribute size [r] The number of elements in the bag.
  #   Performance: O(1) time and O(1) space.
  #   @return [Integer] The number of elements in the bag.
  # @!attribute length [r] The number of elements in the bag.
  #   Performance: O(1) time and O(1) space.
  #   @return [Integer] The number of elements in the bag.
  class BagLinkedList
    # A node for the singly-linked list
    # @api private
    BagNode = Struct.new(:item, :next_node)

    include Enumerable
    attr_reader :size
    alias length size

    # Initialize an empty bag.
    # Performance: O(1) time and O(1) space.
    def initialize
      @first = nil
      @size = 0
    end

    # Is the bag empty?
    # Performance: O(1) time and O(1) space.
    # @return [Boolean] true if empty, false otherwise.
    def empty?
      @size == 0
    end

    # Add an item to the bag.
    # Performance: O(1) time and O(1) additional space for each item.
    # @param item [Object] the item to add.
    # @return [void]
    def add(item)
      @first = BagNode.new(item, @first)
      @size += 1
    end

    # Enumerate over each item in the bag in arbitrary order.
    # Performance: O(n) time and O(1) additional space.
    # @yield [Object] the items in the bag in arbitrary order.
    # @return [self] if given a block.
    # @return [Enumerator] an enumerator to the items if not given a block.
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
  # Read lines from ARGF and put them in the bag.
  # Then print out the size of the bag.
  # Then print the items in the bag.
  if __FILE__ == $PROGRAM_NAME
    bag = BagLinkedList.new
    ARGF.readlines.each { |l| bag.add(l.chomp) }

    puts "Size of bag = #{bag.size}"
    bag.each { |x| puts x }
  end
end

###############################################################################
# The code in this file is based on the java code in LinkedBag from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# bag_linked_list.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# bag_linked_list.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with bag_linked_list.rb.  If not, see http://www.gnu.org/licenses.
################################################################################

module Algs4Ruby
  # BagResizingArray
  #
  # A multiset of generic items.
  # It supports insertaion and iteration over the items in arbitrary order.
  # This implementation is implemented with a resizing array. Initialization
  # querying the number of items and checking if the bag is empty all take
  # constant time in the worst case. Adding an item takes constant amortized
  # time and iterating over the bag takes time linearly proportional to the
  # number of items in the bag.
  #
  # The class includes Enumerable and all those operations also take time
  # proportional to the number of items in the bag.
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
  #   Performance: O(1) worst case time and O(1) space.
  #   @return [Integer] The number of elements in the bag.
  # @!attribute length [r] The number of elements in the bag.
  #   Performance: O(1) worst case time and O(1) space.
  #   @return [Integer] The number of elements in the bag.
  class BagResizingArray
    include Enumerable
    attr_reader :size
    alias length size

    # Initialize an empty bag.
    # Performance: O(1) worst case time and O(1) space.
    def initialize
      @items = Array.new(2)
      @size = 0
    end

    # Add an item to the bag.
    # Performance: O(1) amortized time.
    # @param item [Object] the item to add.
    # @return [void]
    def add(item)
      resize(2 * capacity) if @size == capacity

      @items[@size] = item
      @size += 1
    end

    # Is the bag empty?
    # Performance: O(1) worst case time.
    # @return [Boolean] true if empty, false otherwise.
    def empty?
      @size == 0
    end

    # Enumerate over each item in the bag in arbitrary order.
    # Performance: O(n) worst case time and O(1) additional space.
    # @yield [Object] the items in the bag in arbitrary order.
    # @return [self] if given a block.
    # @return [Enumerator] an enumerator to the items if not given a block.
    def each
      return enum_for :each unless block_given?

      @size.times { |i| yield @items[i] }

      self
    end

    private

    # The capacity of the array.
    # Performance: O(1) worst case time.
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
      if new_cap <= @size
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
  # Read lines from ARGF and put them in the bag.
  # Then print out the size of the bag.
  # Then print the items in the bag.
  if __FILE__ == $PROGRAM_NAME
    bag = BagResizingArray.new
    ARGF.readlines.each { |l| bag.add(l.chomp) }

    puts "Size of bag = #{bag.size}"
    bag.each { |x| puts x }
  end
end

###############################################################################
# The code in this file is based on the java code in ResizingArrayBag from
# alg4.jar library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# bag_resizing_array.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# bag_resizing_array.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with bag_resizing_array.rb.  If not, see http://www.gnu.org/licenses.
################################################################################

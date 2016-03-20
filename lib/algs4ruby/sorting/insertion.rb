module Algs4Ruby
  # The Insertion module provides methods to insertion sort an array (or other
  # indexable collection). It requires that all elements in the collection
  # have a total order.
  #
  # This implementation makes ~ 1/2 * n**2 compares and exchanges in the worst
  # case, so it is not suitable for sorting large arbitrary arrays. More
  # precisely, the number of exchanges is exactly equal to the number of
  # inversions. So, for example, it sorts partially-sorted array in linear time.
  #
  # The sorting algorithm is stable and uses O(1) extra memory for the mutating
  # sort and O(n) for the non-mutating sort.
  #
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # Testing client:
  #   ruby insertion.rb in1 in2 in3
  #   ruby insertion.rb < in
  #   ruby insertion.rb
  #     string1
  #     string2
  #     string3
  #
  # Read lines from ARGF and insertion sorts them.
  # Then prints them to standard output in ascending order.
  module Insertion
    class << self
      # Sort the given array, without mutating the source array.
      # @overload sort(array)
      #   @param array [Array<Comparable>]
      #   @return [Array] a copy of the source array in sorted order.
      #
      # @overload sort(array, slice)
      #   @param array [Array<Comparable>]
      #   @param slice [Range<Integer>] the range of the sub-array indices to
      #   sort.
      #   @return [Array] a copy of the source array in sorted order.
      def sort(array, slice = 0...array.size, &block)
        copy = array.dup

        slice.each do |i|
          while i > slice.first && less?(copy, i, i - 1, &block)
            swap(copy, i, i - 1)
            i -= 1
          end
        end

        copy
      end

      # Sort the given array in place.
      # @overload sort(array)
      #   @param array [Array<Comparable>]
      #   @return [Array] the source array in sorted order.
      #
      # @overload sort(array, slice)
      #   @param array [Array<Comparable>]
      #   @param slice [Range<Integer>] the range of the sub-array indices to
      #   sort.
      #   @return [Array] the source array in sorted order.
      def sort!(array, slice = 0...array.size, &block)
        slice.each do |i|
          while i > slice.first && less?(array, i, i - 1, &block)
            swap(array, i, i - 1)
            i -= 1
          end
        end

        array
      end

      private

      # Swap to elements of the array in place.
      # @param array [Array] the array to mutate.
      # @param a [Integer] an index into the array (unchecked).
      # @param b [Integer] an index into the array (unchecked).
      # @return [void]
      def swap(array, a, b)
        temp = array[a]
        array[a] = array[b]
        array[b] = temp
      end

      # @overload less?(array, a, b)
      #   Is the element at index a less than the element at index b according
      #   to a#<(b)?
      #   @param array [Array<Comparable>] elements of the array must have a
      #     total order.
      #   @param a [Integer] an index into the array (unchecked).
      #   @param b [Integer] an index into the array (unchecked).
      #   @return [Boolean] true if a < b.
      # @overload less?(array, a, b, &comparator)
      #   Is the element at index a less than the element at index b according
      #   to the comparator
      #   @param array [Array<Comparable>] elements of the array must have a
      #     total order.
      #   @param a [Integer] an index into the array (unchecked).
      #   @param b [Integer] an index into the array (unchecked).
      #   @yieldreturn [-1, 0, 1] -1 if array[a] < array[b], 0 if array[a] ==
      #     array[b], or 1 if array[a] > array[b].
      #   @return [Boolean] true if a < b.
      def less?(array, a, b)
        if block_given?
          yield(array[a], array[b]) < 0
        else
          array[a] < array[b]
        end
      end
    end
  end

  # Testing client
  #
  # Read lines from ARGF and insertion sorts them.
  # Then prints them to standard output in ascending order.
  if __FILE__ == $PROGRAM_NAME
    lines = ARGF.readlines
    sorted_lines = Insertion.sort(lines)

    sorted_lines.each { |l| puts l }
  end
end

###############################################################################
# The code in this file is based on the java code in Insertion from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# insertion.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# insertion.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with insertion.rb. If not, see http://www.gnu.org/licenses.
################################################################################

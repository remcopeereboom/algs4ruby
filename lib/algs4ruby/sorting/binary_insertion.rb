module Algs4Ruby
  # BinaryInsertion
  #
  # The {BinaryInsertion} module provides methods to insertion sort an array
  # (or other indexable collections). It requires that all elements have a
  # total order.
  #
  # This implementation makes ~ n log n compares for any array, however in the
  # worst case the running time is quadratic because the number of array
  # accesses can be proportional to n**2 (e.g. if the array is reverse sorted).
  # As such, it is not suitable for sorting large arrays (unless the number of
  # inversions is known to be small).
  #
  # Binary insertion sorting works because we the sorting algorithm maintains
  # a sorted subarray into which unsorted elements are inserted. Since the
  # sub-array is sorted, it can use binary search to quickly find the place of
  # insertion, reducing the number of comparissons from O(n) to O(log n). This
  # is useful if (and really only if) the cost of comparisson is significant
  # (e.g. when sorting large strings or objects with many attributes).
  #
  # The sorting algorithm is stable and uses O(1) extra memory for the mutating
  # sort and O(n) for the non-mutating sort.
  #
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # Testing client:
  #   ruby binary_insertion.rb in1 in2 in3
  #   ruby binary_insertion.rb < in
  #   ruby binary_insertion.rb
  #     string1
  #     string2
  #     string3
  #
  # Read lines from ARGF and insertion sorts them.
  # Then prints them to standard output in ascending order.
  module BinaryInsertion
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
        sort!(array.dup, slice.dup, &block)
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
          value = array[i]

          low = slice.min
          high = i

          while low < high
            middle = low + (high - low) / 2
            if less?(array, i, middle, &block)
              high = middle
            else
              low = middle + 1
            end
          end

          i.downto(low) { |j| array[j] = array[j - 1] }
          array[low] = value
        end


        array
      end

      private

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
  # Read lines from ARGF and binary insertion sorts them.
  # Then prints them to standard output in ascending order.
  if __FILE__ == $PROGRAM_NAME
    lines = ARGF.readlines
    sorted_lines = BinaryInsertion.sort(lines)

    sorted_lines.each { |l| puts l }
  end
end

###############################################################################
# The code in this file is based on the java code in BinaryInsertion
# from alg4.jar library. That library can be found at
# http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# binary_insertion.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# binary_insertion.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with binary_insertion.rb. If not, see http://www.gnu.org/licenses.
################################################################################

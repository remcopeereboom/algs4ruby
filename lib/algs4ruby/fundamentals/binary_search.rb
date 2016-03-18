module Algs4Ruby
  # BinarySearch
  #
  # The BinarySearch module provides a method to binary search a key from a
  # sorted array of items.
  #
  # The #index_of operation takes logarithmic time in the worst case.
  #
  # Testing client
  #   ruby binary_search tinyW.txt < tinyT.txt
  #
  # Read in a sequence of integers from a whitelist file, specified as a
  # command-line argument. Next reads in integers from standard input and
  # prints those numbers to standard output that do not appear in the file.
  module BinarySearch
    class << self
      # Returns the index of the specified key in the specified array.
      # Performance: O(log n) time and O(1) space.
      # @param array [Array<Comparable>] an array of elements who all subscribe
      #   to a total order. The array has to be sorted. If the array is not
      #   sorted, than the result of the method is undefined.
      # @param key [Object(Comparable)] an element to look for in the array.
      # @return [-1] if the key is not in the array.
      # @return [Integer] the index of the key in the array if the key is found.
      def index_of(array, key)
        low = 0
        high = array.size - 1

        while low <= high
          middle = low + (high - low) / 2

          if key < array[middle]
            high = middle - 1
          elsif key > array[middle]
            low = middle + 1
          else
            return middle
          end
        end

        -1 # Key not found!
      end
    end
  end

  # Testing client
  #
  # Read in a sequence of integers from a whitelist file, specified as a
  # command-line argument. Next reads in integers from standard input and
  # prints those numbers to standard output that do not appear in the file.
  if __FILE__ == $PROGRAM_NAME
    whitelist = File.read(ARGV.pop).split.map(&:to_i).sort

    while (key = gets.chomp)
      puts key if BinarySearch.index_of(whitelist, key) != -1
    end
  end
end

###############################################################################
# The code in this file is based on the java code in BinarySearch from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# binary_search.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# binary_search.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with binary_search.rb.  If not, see http://www.gnu.org/licenses.
################################################################################

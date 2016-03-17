module Algs4Ruby
  # The ThreeSum module provides methods for counting and printing the number
  # of triples in an array of numbers that sum to 0.
  #
  # This implementation uses triply nested loops and takes time proportional
  # to n**3, where n is the number of elements in the array.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # Testing client
  #   ruby three_sum.rb input_file
  #   ruby three_sum.rb 
  #     20
  #     12
  #     -32
  #
  # Read lines from ARGF and converts each line to an INTEGER.
  # Counts the number of triplets that sum to zero and prints out the time to
  # perform the computation.
  module ThreeSum
    class << self
      # Count the number of triplets combinations in array that sum to 0.
      # @param array [Array<Numeric>] an array of numbers.
      # @return [Integer] the number of triplets that sum to 0.
      def count(array)
        n = array.length

        count = 0
        (0...n).each do |i|
          ((i + 1)...n).each do |j|
            ((j + 1)...n).each do |k|
              count += 1 if (array[i] + array[j] + array[k]) == 0
            end
          end
        end

        count
      end

      # Print all the triplet combinations in array that sum to 0.
      # @param array [Array<Numeric>] an array of numbers.
      # @return [void]
      def print_all(array)
        a = array
        n = array.length

        (0...n).each do |i|
          ((i + 1)...n).each do |j|
            ((j + 1)...n).each do |k|
              puts "#{a[i]} #{a[j]} #{a[k]}" if (a[i] + a[j] + a[k]) == 0
            end
          end
        end
      end
    end
  end

  # Testing client
  #   ruby three_sum.rb input_file
  #   ruby three_sum.rb 
  #     20
  #     12
  #     -32
  #
  # Read lines from ARGF and converts each line to an INTEGER.
  # Counts the number of triplets that sum to zero and prints out the time to
  # perform the computation.
  if __FILE__ == $PROGRAM_NAME
    xs = ARGF.readlines.map(&:to_i)

    puts "Number of triplets: #{ThreeSum.count(xs)}"
  end
end

###############################################################################
# The code in this file is based on the java code in ThreeSum from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# three_sum.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# three_sum.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with three_sum.rb. If not, see http://www.gnu.org/licenses.
################################################################################

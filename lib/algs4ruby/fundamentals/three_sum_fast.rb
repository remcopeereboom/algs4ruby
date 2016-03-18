module Algs4Ruby
  # ThreeSumFast
  #
  # The ThreeSumFast module provides methods for counting and printing the
  # number of triples in an array of numbers that sum to 0.
  #
  # This implementation uses sorting and binary search and takes time
  # proportional to n**2 * log n, where n is the number of elements in the
  # array.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # Testing client
  #   ruby three_sum_fast.rb input_file
  #   ruby three_sum_fast.rb 
  #     20
  #     12
  #     -32
  #
  # Read lines from ARGF and converts each line to an INTEGER.
  # Counts the number of triplets that sum to zero and prints out the time to
  # perform the computation.
  module ThreeSumFast
    class << self
      def count(array)
        n = array.length

        a = array.sort!

        count = 0
        (0...n).each do  |i|
          ((i + 1)...n).each do |j|
            k = BinarySearch.index_of(a, -(a[i] + a[j]))
            count += 1 if k > j
          end
        end

        count
      end

      # Print all the triplet combinations in array that sum to 0.
      # @param array [Array<Numeric>] an array of numbers.
      # @return [void]
      def print_all(array)
        n = array.length

        a = array.sort!

        (0...n).each do  |i|
          ((i + 1)...n).each do |j|
            k = BinarySearch.index_of(array, -(array[i] + array[j]))
            puts "#{a[i]} #{a[j]} #{a[k]}" if k > j
          end
        end
      end
    end
  end

  # Testing client
  #   ruby three_sum_fast.rb input_file
  #   ruby three_sum_fast.rb 
  #     20
  #     12
  #     -32
  #
  # Read lines from ARGF and converts each line to an INTEGER.
  # Counts the number of triplets that sum to zero and prints out the time to
  # perform the computation.
  if __FILE__ == $PROGRAM_NAME
    require_relative 'stopwatch'

    xs = ARGF.readlines.map(&:to_i)

    timer = Stopwatch.new
    count = ThreeSumFast.count(xs)
    time = timer.elapsed_time

    puts "Elapsed time: #{time}"
    puts "Number of triplets: #{count}"
  end
end

###############################################################################
# The code in this file is based on the java code in ThreeSumFast from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# three_sum_fast.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# three_sum_fast.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with three_sum_fast.rb. If not, see http://www.gnu.org/licenses.
################################################################################

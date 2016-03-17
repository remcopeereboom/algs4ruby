#!/usr/bin/env ruby

module Algs4Ruby
  # StandardStats
  # Library of statistical functions.
  #
  # Testing client:
  #   ruby std_stats.rb n1 n2 n3 ...
  #
  # The test client reads an array of numbers from standard input and then
  # prints out some statistics about them.
  module StandardStats
    class << self
      # @overload min(array)
      #   Returns the minimum element of the array.
      #   @param array [Array<Comparable>] an array whose elements are subject
      #     to a total ordering.
      #   @return [Float::INFINITY] if the array is empty.
      #   @return [Object] the minimum element.
      # @overload min(array, low, high)
      #   Returns the minimum element of the sub-array.
      #   @param array [Array<Comparable>] an array whose elements are subject
      #     to a total ordering.
      #   @param low [Integer] the lower index of the sub-array (inclusive).
      #   @param high [Integer] the upper index of the sub-array (inclusive).
      #   @return [Float::INFINITY] if the array is empty.
      #   @return [Object] the minimum element.
      #   @raise [RangeError] if low < 0
      #   @raise [RangeError] if high < array.size
      #   @raise [RangeError] if low > high
      def min(array, low = 0, high = array.size - 1)
        return Float::INFINITY if array.empty?

        if low < 0 || high >= array.size || low > high
          fail RangeError, "Invalid sub-array (#{low}..#{high})."
        end

        array[low..high].min
      end

      # @overload max(array)
      #   Returns the maximum element of the array.
      #   @param array [Array<Comparable>] an array whose elements are subject
      #     to a total ordering.
      #   @return [Object] the maximum element.
      #   @return [-Float::INFINITY] if the array is empty.
      # @overload max(array, low, high)
      #   Returns the maximum element of the sub-array.
      #   @param array [Array<Comparable>] an array whose elements are subject
      #     to a total ordering.
      #   @param low [Integer] the lower index of the sub-array (inclusive).
      #   @param high [Integer] the upper index of the sub-array (inclusive).
      #   @return [-Float::INFINITY] if the array is empty.
      #   @return [Object] the maximum element.
      #   @raise [RangeError] if low < 0
      #   @raise [RangeError] if high < array.size
      #   @raise [RangeError] if low > high
      def max(array, low = 0, high = array.size - 1)
        return -Float::INFINITY if array.empty?

        if low < 0 || high >= array.size || low > high
          fail RangeError, "Invalid sub-array (#{low}..#{high})."
        end

        array[low..high].max
      end

      # @overload sum(array)
      #   Returns the sum of the elements of the array.
      #   @param array [Array<Numeric>] an array of sumable elements.
      #   @return [Numeric] the sum of all the elements.
      #   @return [0] if the array is empty.
      # @overload sum(array, low, high)
      #   Returns the sum of all the elements in the sub-array.
      #   @param array [Array<Numeric>] an array of sumable elements.
      #   @param low [Integer] the lower index of the sub-array (inclusive).
      #   @param high [Integer] the upper index of the sub-array (inclusive).
      #   @return [Numeric] the sum of the elements of the sub-array.
      #   @return [0] if the array is empty.
      #   @raise [RangeError] if low < 0
      #   @raise [RangeError] if high < array.size
      #   @raise [RangeError] if low > high
      def sum(array, low = 0, high = array.size - 1)
        return 0 if array.empty?

        if low < 0 || high >= array.size || low > high
          fail RangeError, "Invalid sub-array (#{low}..#{high})."
        end

        array[low..high].inject(0, :+)
      end

      # @overload mean(array)
      #   Returns the mean of the elements of the array.
      #   @param array [Array<Numeric>] an array of sumable elements.
      #   @return [Float::NAN] if the array is empty.
      #   @return [Numeric] the mean of all the elements.
      # @overload mean(array, low, high)
      #   Returns the mean of the elements of the sub-array.
      #   @param array [Array<Numeric>] an array of sumable elements.
      #   @param low [Integer] the lower index of the sub-array (inclusive).
      #   @param high [Integer] the upper index of the sub-array (inclusive).
      #   @return [Float::NAN] if the array is empty.
      #   @return [Numeric] the mean of the elements of the sub-array.
      #   @raise [RangeError] if low < 0
      #   @raise [RangeError] if high < array.size
      #   @raise [RangeError] if low > high
      def mean(array, low = 0, high = array.size - 1)
        return Float::NAN if array.empty?

        if low < 0 || high >= array.size || low > high
          fail RangeError, "Invalid sub-array (#{low}..#{high})."
        end

        slice = array[low..high]
        slice.inject(0.0, :+) / slice.size
      end

      # @see StandardStats.varp varp for the POPULATION variance.
      # @overload var(array)
      #   Returns the sample variance of the elements of the array.
      #   @param array [Array<Numeric>]
      #   @return [Float::NAN] if the array is empty.
      #   @return [Float] the sample variance.
      # @overload var(array, low, high)
      #   Returns the sample variance of the elements of the sub-array
      #   low..high.
      #   @param array [Array<Numeric>]
      #   @param low [Integer] the lower index of the sub-array (inclusive).
      #   @param high [Integer] the upper index of the sub-array (inclusive).
      #   @return [Float::NAN] if the array is empty.
      #   @return [Float] the sample variance.
      #   @raise [RangeError] if low < 0
      #   @raise [RangeError] if high < array.size
      #   @raise [RangeError] if low > high
      def var(array, low = 0, high = array.size - 1)
        return Float::NAN if array.empty?

        if low < 0 || high >= array.size || low > high
          fail RangeError, "Invalid sub-array (#{low}..#{high})."
        end

        avg = mean(array, low, high)
        sum = (low..high).inject(0.0) do |acc, i|
          acc + (array[i] - avg) * (array[i] - avg)
        end

        sum / (high - low)
      end

      # @see StandardStats.var var for the SAMPLE variance.
      # @overload varp(array)
      #   Returns the population variance of the elements of the array.
      #   @param array [Array<Numeric>]
      #   @return [Float::NAN] if the array is empty.
      #   @return [Float] the sample variance.
      # @overload varp(array, low, high)
      #   Returns the sample variance of the elements of the sub-array
      #   low..high.
      #   @param array [Array<Numeric>]
      #   @param low [Integer] the lower index of the sub-array (inclusive).
      #   @param high [Integer] the upper index of the sub-array (inclusive).
      #   @return [Float::NAN] if the array is empty.
      #   @return [Float] the population variance.
      #   @raise [RangeError] if low < 0
      #   @raise [RangeError] if high < array.size
      #   @raise [RangeError] if low > high
      def varp(array, low = 0, high = array.size - 1)
        return Float::NAN if array.empty?

        if low < 0 || high >= array.size || low > high
          fail RangeError, "Invalid sub-array (#{low}..#{high})."
        end

        avg = mean(array, low, high)
        s = (low..high).inject(0.0) do |acc, i|
          acc + (array[i] - avg) * (array[i] - avg)
        end

        s / (high - low + 1)
      end

      # @see StandardStats.stddevp stddevp for the POPULATION standard
      # deviation.
      # @overload stddev(array)
      #   Returns the sample standard deviation of the array.
      #   @param array [Array<Numeric>]
      #   @return [Float::NAN] if the array is empty.
      #   @return [Float] the sample standard deviation.
      # @overload stddev(array, low, high)
      #   Returns the sample standard deviation of the sub-array
      #   low..high.
      #   @param array [Array<Numeric>]
      #   @param low [Integer] the lower index of the sub-array (inclusive).
      #   @param high [Integer] the upper index of the sub-array (inclusive).
      #   @return [Float::NAN] if the array is empty.
      #   @return [Float] the population standard deviation.
      #   @raise [RangeError] if low < 0
      #   @raise [RangeError] if high < array.size
      #   @raise [RangeError] if low > high
      def stddev(array, low = 0, high = array.size - 1)
        Math.sqrt(var(array, low, high))
      end

      # @see StandardStats.stddev stddev for the SAMPLE standard
      # deviation.
      # @overload stddev(array)
      #   Returns the population standard deviation of the array.
      #   @param array [Array<Numeric>]
      #   @return [Float::NAN] if the array is empty.
      #   @return [Float] the sample standard deviation.
      # @overload stddev(array, low, high)
      #   Returns the population standard deviation of the sub-array
      #   low..high.
      #   @param array [Array<Numeric>]
      #   @param low [Integer] the lower index of the sub-array (inclusive).
      #   @param high [Integer] the upper index of the sub-array (inclusive).
      #   @return [Float::NAN] if the array is empty.
      #   @return [Float] the population standard deviation.
      #   @raise [RangeError] if low < 0
      #   @raise [RangeError] if high < array.size
      #   @raise [RangeError] if low > high
      def stddevp(array, low = 0, high = array.size - 1)
        Math.sqrt(varp(array, low, high))
      end
    end
  end

  # Testing client
  if __FILE__ == $PROGRAM_NAME
    p a = ARGV.map(&:to_f)

    puts "min: #{StandardStats.min(a)}"
    puts "max: #{StandardStats.max(a)}"
    puts "mean: #{StandardStats.mean(a)}"
    puts "stddev: #{StandardStats.stddev(a)}"
    puts "var: #{StandardStats.var(a)}"
    puts "stddevp: #{StandardStats.stddevp(a)}"
    puts "varp: #{StandardStats.varp(a)}"
  end
end

###############################################################################
# The code in this file is based on the java code in StdStats from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# standard_stats.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# standard_stats.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with standard_stats.rb. If not, see http://www.gnu.org/licenses.
################################################################################

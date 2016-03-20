module Algs4Ruby
  # Accumulator
  #
  # The Accumulator class is a data type for computing the running mean, sample
  # standard deviation, and sample variance of a stream of real numbers. It
  # provides an example of both a mutable data type and of a streaming
  # algorithm.
  #
  # This implementation uses a one-pass algorithm that is less susceptible to
  # floating point roundoff errors than the more straightforward implementation
  # based on saving the sum of the squares of the numbers.
  # This technique is due to B. P. Welford
  # @see https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance
  #
  # Each operation takes constant time in the worst case.
  # The amount of memory is constant - the data values are not stored.
  #
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # Testing client:
  #   ruby accumulator.rb in1 in2 in3
  #   ruby accumulator.rb < in
  #   ruby accumulator.rb
  #     23.3
  #     234
  #     231.0
  #     -3.2e-3
  #
  # Read lines from ARGF and convert them to floating point numbers.
  # Add the numbers to the accumulator.
  # Print out statistics about the list.
  #
  # @!attribute count [r] The nummber of data points accumulated thus far.
  #   @return [Integer] the number of data points.
  # @!attribute mean [r] The mean of the data points accumulated thus far.
  #   @return [0.0] if no points added yet.
  #   @return [Float] the mean.
  class Accumulator
    attr_reader :count, :mean

    # Initializes a new accumulator.
    def initialize
      @sum = 0.0
      @mean = 0.0
      @count = 0
    end

    # Adds a data value to the accumulator.
    # @param x [Numeric] a number to add.
    # @return [void]
    def add_data_value(x)
      @count += 1
      delta = x.to_f - @mean
      @mean += delta / @count
      @sum += (@count - 1.0) / @count * delta * delta
    end

    # Returns the sample variance of the data points accumulated thus far.
    # @return [-0.0] if no data points added yet.
    # @return [Float::INFINITY, Float::NAN] if one data point added (due to 
    #   insufficient degrees of freedom).
    # @return [Float] the sample variance if more than one data point has
    #   been added so far.
    def var
      @sum / (@count - 1)
    end

    # Returns the sample standard deviation of the data points accumulated thus
    # far.
    # @return [0.0] if no data points added yet.
    # @return [Float::INFINITY, Float::NAN] if one data point added (due to 
    #   insufficient degrees of freedom).
    # @return [Float] the sample standard deviation if more than one data point
    #   has been added so far.
    def stddev
      Math.sqrt(var)
    end
  end

  # Testing client
  #
  # Read lines from ARGF and convert them to floating point numbers.
  # Add the numbers to the accumulator.
  # Print out statistics about the list.
  if __FILE__ == $PROGRAM_NAME
    stats = Accumulator.new
    ARGF.readlines.each { |l| stats.add_data_value(l.to_f) }

    puts "N      = #{stats.count}"
    puts "mean   = #{stats.mean}"
    puts "stddev = #{stats.stddev}"
    puts "var    = #{stats.var}"
  end
end

###############################################################################
# The code in this file is based on the java code in Accumulator from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# accumulator.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# accumulator.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with accumulator.rb. If not, see http://www.gnu.org/licenses.
################################################################################

module Algs4Ruby
  # Stopwatch
  #
  # The Stopwatch data type is for measuring the time that elapses between the
  # start and end of a programming task (wall-clock time).
  #
  # @see StopwatchCPU for a version that measures CPU time.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # Testing client
  #   ruby stopwatch.rb input_file
  #
  # Takes a command-line argument n and computes the sum of the square roots of
  # the first n positive integers, first using Math.sqrt and then using #**.
  # It prints to standard output the sum and the amount of time to compute the
  # sum. Note that the discrete sum can be approximated by an integeral - the
  # sum should be approximately 2/3 * (n**(3/2) - 1).
  class Stopwatch
    # Initialize a new Stopwatch
    def initialize
      @start = Time.now
    end

    # Return the elapsed time in seconds since the stopwatch was created.
    # @return [Float]
    def elapsed_time
      Time.now - @start
    end
  end

  # Testing client
  #   ruby stopwatch.rb input_file
  #
  # Takes a command-line argument n and computes the sum of the square roots of
  # the first n positive integers, first using Math.sqrt and then using #**.
  # It prints to standard output the sum and the amount of time to compute the
  # sum. Note that the discrete sum can be approximated by an integeral - the
  # sum should be approximately 2/3 * (n**(3/2) - 1).
  if __FILE__ == $PROGRAM_NAME
    n = ARGV.pop.to_i

    timer_1 = Stopwatch.new
    sum_1 = (1..n).inject(0.0) { |sum, i| sum + Math.sqrt(i) }
    time_1 = timer_1.elapsed_time

    timer_2 = Stopwatch.new
    sum_2 = (1..n).inject(0.0) { |sum, i| sum + i**0.5 }
    time_2 = timer_2.elapsed_time

    puts "Sum of square roots upto #{n}"
    puts "using Math.sqrt: #{sum_1} (computed in #{time_1} seconds."
    puts "using i**0.5:    #{sum_2} (computed in #{time_2} seconds."
  end
end

###############################################################################
# The code in this file is based on the java code in Stopwatch from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# stopwatch.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# stopwatch.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with stopwatch.rb. If not, see http://www.gnu.org/licenses.
################################################################################

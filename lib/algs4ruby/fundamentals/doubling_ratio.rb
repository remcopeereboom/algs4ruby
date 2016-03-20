module Algs4Ruby
  # DoublingRatio
  #
  # The DoublingRatio module is a client for measuring the running time of a
  # method using a doubling ratio test.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # Testing client
  #   ruby doubling_ratio.rb
  #
  # Prints a table of running times to call ThreeSum#count for arrays of
  # size 250, 500, 1000, 2000 and so forth, along with ratios of running times
  # between successive array sizes.
  module DoublingRatio
    class << self
      RANDOM_RANGE = -1_000_000..1_000_000

      # Returns the amount of time to call ThreeSum#count with n
      # random 6-digit integers.
      # @param n [Integer] the number of integers.
      # @return [Integer] the amount of time in seconds to run ThreeSum#count
      #   with n random 6-digit integers.
      def time_trial(n)
        a = Array.new(n) { rand(RANDOM_RANGE) }

        timer = Stopwatch.new
        ThreeSum.count(a)
        timer.elapsed_time
      end
    end
  end

  # Testing client
  #   ruby doubling_ratio.rb
  #
  # Prints a table of running times to call ThreeSum#count for arrays of
  # size 250, 500, 1000, 2000 and so forth, along with ratios of running times
  # between successive array sizes.
  if __FILE__ == $PROGRAM_NAME
    require_relative 'stopwatch'
    require_relative 'three_sum'

    prev = DoublingRatio.time_trial(125)

    n = 250
    loop do
      time = DoublingRatio.time_trial(n)
      puts "n: #{n}"
      puts "time: #{time}"
      puts "ratio: #{time / prev}"
      prev = time
      n *= 2
    end
  end
end

###############################################################################
# The code in this file is based on the java code in DoublingRatio from
# alg4.jar library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# doubling_ratio.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# doubling_ratio.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with doubling_ratio.rb. If not, see http://www.gnu.org/licenses.
################################################################################

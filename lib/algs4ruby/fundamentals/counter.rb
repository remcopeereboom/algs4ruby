module Algs4Ruby
  # Counter
  #
  # The Counter class is a mutable data type to encapsulate a counter.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # testing client:
  #   counter n t
  #
  # The client takes 2 integers as command line arguments. The first specifies
  # the number of counters to create. The second specifies the number of times
  # to increment a random counter.
  # After t times incrementing a random counter the program prints out the count
  # of all the counters.
  #
  #
  # @!attribute tally [r] the number of times the counter has been incremented.
  #   Performance: O(1) time and O(1) space.
  #   @return [integer] the tally.
  # @!attribute count [r] the number of times the counter has been incremented.
  #   Performance: O(1) time and O(1) space.
  #   @return [integer] the tally.
  class Counter
    include Comparable
    attr_reader :id
    attr_reader :tally
    alias count tally

    # Initializes a new counter.
    # Perfomance: O(1) time and O(1) space.
    def initialize(id)
      @id = id
      @tally = 0
    end

    # Increments the counter by 1.
    # Performance: O(1) time and O(1) space.
    # @return [Integer] the new count.
    def increment
      @tally += 1
    end

    # Compares two counters.
    # Performance: O(1) time and O(1) space.
    # @param other [Counter]
    # @return [Integer] a negative value if self.count < other.count;
    #   0 if self.count == other.count; and a positive value if self.count >
    #   other.count.
    def <=>(other)
      @tally <=> other.tally
    end

    # Returns a string representation of the counter.
    # Performance: O(1) time and O(1) space.
    # @return [String]
    def to_s
      "#{count} #{id}"
    end
  end

  # Testing client
  #
  # Reads two command-line integers n and t.
  # Creates n counters.
  # Increments t counters at random.
  # Prints the count of the counters.
  if __FILE__ == $PROGRAM_NAME
    require_relative '../standard_io_libraries/standard_random'

    n, t = ARGV.map(&:to_i)

    hits = n.times.map { |i| Counter.new("counter #{i}") }
    t.times { hits[StandardRandom.uniform(n)].increment }

    n.times { |i| puts hits[i] }
  end
end

###############################################################################
# The code in this file is based on the java code in Counter from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# counter.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# counter.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with counter.rb. If not, see http://www.gnu.org/licenses.
################################################################################

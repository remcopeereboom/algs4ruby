module Algs4Ruby
  # UnionFind
  #
  # The UnionFind class represents a disjoint-sets data type.
  # A Disjoint-set keeps track of a set of elements partioned into a number of
  # disjoint (non-overlapping) subsets.
  #
  # This implementation makes use of union by rank and path compression to
  # achieve make all operations extremely efficient.
  # Initialization takes time proportional to the number of elements in the set.
  # The #find, #union and #connected? operations all take logarithmic time in
  # worst case and amortized per operation time proportional to the inverse
  # Ackermann function applied to the number of elements in the set
  # (virtually constant). The #size operation takes constant time in the worst
  # case.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  #
  # Testing client:
  #   ruby union_find.rb
  #   10
  #   1 2
  #   2 3
  #   5 6
  #   6 6
  #   5 3
  #
  # Reads in an integer n, and a sequence of pairs of integers in the range
  # 0...n from standard inpt, where each integer in the pair represents some
  # site.
  # If the sites are in different components, merge the two pairs and print the
  # pair to standard output.
  #
  # @!attribute size [r] the number of distinct components in the set
  #   This number is at least 1 and never larger than the number of elements in
  #   the set.
  #   @return [Integer] the number of connected components.
  # @!attribute length [r] the number of distinct components in the set
  #   This number is at least 1 and never larger than the number of elements in
  #   the set.
  #   @return [Integer] the number of connected components.
  # @!attribute count [r] the number of distinct components in the set
  #   This number is at least 1 and never larger than the number of elements in
  #   the set.
  #   @return [Integer] the number of connected components.
  class UnionFind
    attr_reader :size
    alias length size
    alias count size

    # Initializes a new disjoint-set of n elements.
    # @param n [Integer] the number of elements in the set.
    # @raise [ArgumentError] if n < 0.
    def initialize(n)
      if n < 0
        fail ArgumentError,
             "Must have a non-negative number of elements (#{n} for 0+)."
      end

      @parents = Array 0...n
      @ranks = Array.new(n, 0)
      @size = n
    end

    # Return the ID of the connected component for the element with the given
    # index i.
    # @param i [Integer] the index of the element to find.
    # @return [Integer] the ID of the conncented component of element i
    # @raise [RangeError] if i is not a valid index.
    def find(i)
      unless indices.cover? i
        fail RangeError, "Not an element index (#{i} for #{indices})."
      end

      while i != @parents[i]
        @parents[i] = @parents[@parents[i]] # Apply path-compression.
        i = @parents[i]
      end

      i
    end

    # Merge the connected component containing a with the connected component
    # containing b.
    # @param a [Integer] an index of an element.
    # @param b [Integer] an index of an element.
    # @return [void]
    # @raise [RangeError] if a is not a valid index.
    # @raise [RangeError] if b is not a valid index.
    def union(a, b)
      # Find the root of the two trees of connected components.
      root_a = find(a)
      root_b = find(b)

      return if root_a == root_b

      # Make the root of the SMALLER rank point to the root of the larger rank.
      if @ranks[root_a] < @ranks[root_b]
        @parents[root_a] = root_b
      elsif @ranks[root_a] > @ranks[root_b]
        @parents[root_b] = root_a
      else # Equal rank
        @parents[root_b] = root_a # Just pick one to be the root..
        @ranks[root_a] += 1
      end

      @size -= 1 # Reduce the total number of connected components.
    end

    # Are a and b in connected, i.e. are they in the same connected component?
    # @param a [Integer] an index to an element.
    # @param b [Integer] an index to an element.
    # @return [Boolean] true if connected, false otherwise.
    # @raise [RangeError] if a is not a valid index.
    # @raise [RangeError] if b is not a valid index.
    def connected?(a, b)
      find(a) == find(b)
    end

    private

    # The range of valid element indices.
    # Performance: constant time in the worst case.
    # @return [Range<Integer>]
    def indices
      0...@parents.size
    end
  end

  # Testing client
  #
  # Reads in an integer n, and a sequence of pairs of integers in the range
  # 0...n from standard inpt, where each integer in the pair represents some
  # site.
  # If the sites are in different components, merge the two pairs and print the
  # pair to standard output.
  if __FILE__ == $PROGRAM_NAME
    n = gets.to_i
    uf = UnionFind.new(n)

    while (s = gets)
      a, b = s.split.map(&:to_i)
      next if uf.connected?(a, b)
      uf.union(a, b)
      puts "#{a} #{b}"
    end

    puts "#{uf.count} components"
  end
end

###############################################################################
# The code in this file is based on the java code in UF from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# union_find.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# union_find.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with union_find.rb.  If not, see http://www.gnu.org/licenses.
################################################################################

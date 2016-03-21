module Algs4Ruby
  # MinPQ
  #
  # The MinPQ class represents a priority queue of generic keys. It supports the
  # usual insert and delete-the-minimum operations as well as methods for
  # peeking at the minimum key, testing if the priority queue is empty, and
  # iterating over the keys.
  #
  # This implementation uses a binary heap. The {#insert} and {#delete_min}
  # operations take amortized logarithmic time. The {#min}, {#size}, and
  # {#empty?} operations all take constant time. Initializing a new MinPQ takes
  # time proportional to the specified capacity or the number of items used to
  # initialize the data structure.
  #
  # The class includes Enumerable and all those operations also take time
  # linearly proportional to the number of items in the pq.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # Testing client:
  #   ruby min_pq < in
  #   ruby min_pq
  #     string
  #     string
  #     -
  #     string
  #     -
  #     string
  #
  # Reads in lines from standard input. If the line eq '-' and the pq is not
  # empty, it removes the minimum element from the pq and prints it to
  # standard output. If the line does not equal '-' it adds the line to the
  # pq.
  #
  # @!attribute size [r] The number of keys in the pq.
  #   Performance: O(1) time and O(1) space.
  #   @return [Integer] The number of keys in the pq.
  # @!attribute length [r] The number of keys in the pq.
  #   Performance: O(1) time and O(1) space.
  #   @return [Integer] The number of keys in the pq.
  class MinPQ
    include Enumerable
    attr_reader :size
    alias length size

    # @overload intialize
    #   Initializes a MinPQ which compares items using the greater than operator
    #   (#>).
    # @overload intialize(&comparator)
    #   Initializes a MinPQ which compares items using the comparator block.
    #   @yieldparam a [Object]
    #   @yieldparam b [Object]
    #   @yieldreturn [-1, 0, 1] -1 if a < b; 0 if a == b; and +1 if a > b.
    # @overload initialize(capacity)
    #   Initializes a MinPQ which compares items using the greater than operator
    #   (#>). Reserves space for capacity objects.
    #   @param capacity [Integer] must be non-negative.
    # @overload initialize(capacity, &comparator)
    #   Initializes a MinPQ which compares items using the comparator block.
    #   Reserves space for capacity objects.
    #   @param capacity [Integer] must be non-negative.
    #   @yieldparam a [Object]
    #   @yieldparam b [Object]
    #   @yieldreturn [-1, 0, 1] -1 if a < b; 0 if a == b; and +1 if a > b.
    # @overload initialize(keys)
    #   Initializes a MinPQ from the enumerable of keys. Compares items using
    #   the greater than operator (#>).
    #   @param keys [Enumerable] the keys to add to the pq.
    # @overload initialize(keys, &comparator)
    #   Initializes a MinPQ from the enumerable of keys. Compares items using
    #   the comparator block.
    #   @param keys [Enumerable] the keys to add to the pq.
    #   @yieldparam a [Object]
    #   @yieldparam b [Object]
    #   @yieldreturn [-1, 0, 1] -1 if a < b; 0 if a == b; and +1 if a > b.
    #   @param keys [Enumerable] the keys to add to the pq.
    def initialize(args = 1, &comparator)
      case args
      when Integer
        initialize_from_capacity(args, &comparator)
      when Enumerable
        initialize_from_enumerable(args, &comparator)
      else
        fail ArgumentError,
             "Not a valid overload (#{args.class} for Integer, Enumerable)."
      end
    end

    # Is the priority queue empty?
    # @return [Boolean] true if empty, false otherwise.
    def empty?
      0 == @size
    end

    # Returns the smallest key in the pq.
    # @return [Object]
    # @raise [PriorityQueueEmptyError] if the pq is empty.
    def min
      fail PriorityQueueEmptyError if empty?

      @pq[1]
    end

    # Inserts an item into the pq.
    # @param x [Object]
    # @return [void]
    def insert(x)
      resize(2 * @pq.length) if @size == @pq.length - 1

      @size += 1
      @pq[@size] = x
      swim(@size)
    end

    # Removes the smallest key from the pq and returns it.
    # @return [Object]
    # @raise [PriorityQueueEmptyError] if the pq is empty.
    def delete_min
      fail PriorityQueueEmptyError if empty?

      swap(1, @size)
      minimum = @pq[@size]
      @pq[@size] = nil # Prevent loitering
      @size -= 1

      sink(1)
      resize(@pq.length / 2) if @size > 0 && @size == (@pq.length - 1) / 4

      minimum
    end

    # Iterates over every key in the pq in order of the priority of the keys.
    # @yield [Object] the keys in the pq.
    # @return [Enumerator<:each>] if no block is given.
    # @return [self] if a block is given.
    def each
      return enum_for(:each) { @size } unless block_given?

      # Copy the heap and yield its items.
      copy = MinPQ.new(@size, &@comparator)
      (1..@size).each { |i| copy.insert(@pq[i]) }
      yield copy.delete_min until copy.empty?

      self
    end

    private

    # @overload intialize(capacity)
    #   Initializes a MinPQ which compares items using the greater than operator
    #   (#>). Reserves space for capacity items.
    #   @param capacity [Integer] the amount of items to reserve space for.
    #   @return [void]
    #   @raise [ArgumentError] if capacity < 0
    # @overload intialize(capacity, &comparator)
    #   Initializes a MinPQ which compares items using the given comparator
    #   block. Reserves space for capacity items.
    #   @yieldparam a [Object]
    #   @yieldparam b [Object]
    #   @yieldreturn [-1, 0, 1] -1 if a < b; 0 if a == b; and +1 if a > b.
    #   @param capacity [Integer] the amount of items to reserve space for.
    #   @return [void]
    #   @raise [ArgumentError] if capacity < 0
    def initialize_from_capacity(capacity, &comparator)
      if capacity < 1
        fail ArgumentError, "Capacity must be at least 1 (#{capacity} for 1+)."
      end

      @comparator = comparator
      @pq = Array.new(capacity + 1)
      @size = 0
    end

    # @overload initialize_from_enumerable(keys)
    #   Initializes a MinPQ from the enumerable of keys. Compares items using
    #   the greater than operator (#>).
    #   @param keys [Enumerable] the keys to add to the pq.
    #   @return [void]
    # @overload initialize(keys, &comparator)
    #   Initializes a MinPQ from the enumerable of keys. Compares items using
    #   the comparator block.
    #   @param keys [Enumerable] the keys to add to the pq.
    #   @yieldparam a [Object]
    #   @yieldparam b [Object]
    #   @yieldreturn [-1, 0, 1] -1 if a < b; 0 if a == b; and +1 if a > b.
    #   @return [void]
    def initialize_from_enumerable(keys, &comparator)
      keys = keys.to_a
      @size = keys.length
      @comparator = comparator
      @pq = Array.new(@size + 1) { |i| keys[i - 1] unless i == 0 }

      (@size / 2).downto(1) { |i| sink(i) }
    end

    # Restore the heap invariant, by moving this key up the heap array.
    # @param k [Integer] the key to move up.
    # @return [void]
    def swim(k)
      while k > 1 && greater?(k / 2, k)
        swap(k, k / 2)
        k /= 2
      end
    end

    # Restore the heap invariant, by moving this key down the heap array.
    # @param k [Integer] the key to move down.
    # @return [void]
    def sink(k)
      while 2 * k <= @size
        j = 2 * k
        j += 1 if j < @size && greater?(j, j + 1)
        break unless greater?(k, j)
        swap(k, j)
        k = j
      end
    end

    # Is key at a greater than key at b?
    # If a comparator was given at initialization time, the keys are compared
    # using the comparator, otherwise they are compared using the #> operator.
    # @param a [Integer] the position of the key in the heap array.
    # @param b [Integer] the position of the key in the heap array.
    # @return [Boolean] true if a > b, false otherwise.
    def greater?(a, b)
      if @comparator
        @comparator.call(@pq[a], @pq[b]) > 0
      else
        @pq[a] > @pq[b]
      end
    end

    # Swap the entries at a and b.
    # @param a [Integer] the position of the key in the heap array.
    # @param b [Integer] the position of the key in the heap array.
    # @return [void]
    def swap(a, b)
      temp = @pq[a]
      @pq[a] = @pq[b]
      @pq[b] = temp
    end

    # Resizes the heap array.
    # @param new_cap [Integer] the new size of the heap array. Must be greater
    #   than the current number of items in the heap array.
    # @return [void]
    def resize(new_cap)
      if new_cap < @size
        fail ArgumentError,
             "New capacity (#{new_cap}) must be > than nr of items (#{size})."
      end

      temp = Array.new(new_cap)
      (1..@size).each { |i| temp[i] = @pq[i] }
    end
  end

  # Testing client
  #
  # Read lines from ARGF and put them in the bag.
  # Then print out the size of the bag.
  # Then print the items in the bag.
  if __FILE__ == $PROGRAM_NAME
    pq = MinPQ.new

    while l = gets
      l.chomp!
      if l == '-'
        puts pq.delete_min unless pq.empty?
      else
        pq.insert(l)
      end
    end

    puts "(#{pq.size} items left in the pq)"
  end
end

###############################################################################
# The code in this file is based on the java code in MinPQ from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# min_pq.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# min_pq.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with min_pq.rb.  If not, see http://www.gnu.org/licenses.
################################################################################

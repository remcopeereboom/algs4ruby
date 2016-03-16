module Algs4Ruby
  # StandardRandom
  # A library that extends ruby's built in library to include methods that
  # genereate pseudo-random numbers from different distributions. It also
  # includes a method to shuffle an array which differs from Array#shuffle
  # in that it allows shuffling the subarray and advances the classes rng'
  # seed as opposed to the global/Kernal rng' seed
  #
  # Distributions included are:
  #  - uniform
  #  - bernoulli
  #  - gaussian / normal
  #  - exponential
  #  - discrete sampling
  #
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # Testing client:
  #   ruby std_random.rb n
  #   ruby std_random.rb n seed
  #
  # Takes an integer n as a command-line argument and uses it to n times print
  # random numbers from a variety of distributions. Also takes a seeds as a
  # second optional command-line argument.
  class StandardRandom
    # A globally shared instance.
    # You can call methods on this instance specifically, but you can also call
    # the methods directly on the class and then they will be forwarded to this
    # instance when appropriate.
    # @return [StdRandom]
    def self.rng
      @rng ||= StandardRandom.new
    end

    # Delegate class calls to the rng instance.
    # @api private
    def self.method_missing(method, *arguments)
      if rng.respond_to?(method)
        rng.send(method, *arguments)
      else
        super
      end
    end

    # Initializes a new random nummber generator.
    # @overload initialize
    #   Initializes with a random seed.
    # @overload initialize(seed)
    #   Initializes with the given seed.
    #   @param seed [Integer] the seed for the rng.
    def initialize(seed = Random.new_seed)
      @rng = Random.new(seed)
    end

    # Returns the seed of the rng.
    # @return [Integer] the seed.
    def seed
      @rng.seed
    end

    # Sets the seed of the rng.
    # @param new_seed [Integer] the new seed for the rng.
    # @return [void]
    def seed=(new_seed)
      @rng = Random.new(new_seed)
    end

    # @overload uniform
    #   Returns a random number drawn uniformly from the range 0.0..1.0.
    #   @return [Float] a number in the range 0.0..1.0
    # @overload uniform(n)
    #   Returns a random number drawn uniformly from the range 0..n
    #   @param n [Numeric] the upperbound on the range from which to draw.
    #   @return [Integer] an integer in the range 0..n if n >= 1.
    #   @note Even if n is a float, if it is larger than 1, the return value
    #     will be an Integer, not a Float!
    #   @return [Float] an float in the range 0.0..1.0 if 0 < n < 1.
    #   @raise [ArgumentError] if n <= 0.
    # @overload uniform(range)
    #   @param range [Range<Numeric>] the range of numbers from which to
    #     uniformly draw.
    #   @return [Numeric] a number drawn uniformly from range.
    def uniform(*args)
      @rng.rand(*args)
    end

    # @overload bernoulli
    #   Returns a boolean from a Bernoulli distribution with SUCCESS
    #   probability 0.5.
    #   @return [Boolean]
    # @overload bernoulli(p)
    #   Returns a boolean from a Bernoulli distribution with SUCCESS
    #   propability p.
    #   @param p [Float] probability of succes (0.0..1.0)
    #   @return [Boolean]
    def bernoulli(p = 0.5)
      unless (0.0..1.0).cover? p
        fail ArgumentError,
             "Probability argument p must lie in the range 0.0..1.0 (#{p})."
      end

      uniform < p
    end

    # @overload guassian
    #   Returns a float from the standard Gaussian distribution.
    #   @return [Float]
    # @overload guassian(mean, stddev)
    #   Returns a float from a specified Gaussian distribution.
    #   @param mean [Numeric] the mean of the distribution.
    #   @param stddev [Numeric] the standard deviation of the distribution.
    #   @return [Float]
    def gaussian(mean = 0.0, stddev = 1.0)
      x = y = r = 0.0

      loop do
        x = 2.0 * uniform - 1.0
        y = 2.0 * uniform - 1.0
        r = x * x + y * y

        break unless r >= 1 || r == 0
      end

      standard = x * Math.sqrt(-2.0 * Math.log(r) / r)

      mean + stddev * standard
    end

    # Returns a random integer froma geometric distribution.
    # @param p [Float] a distribution probability p, such that 0 < p <= 1.
    # @return [Integer]
    # @raise [ArgumentError] if p < 0 or p > 1
    # @raise [ArgumentError] if p == 0
    # @note In the Java version of this library, the argument p can be zero.
    #   This ruby port does not allow that.
    def geometric(p)
      if p == 0
        fail ArgumentError,
             'Unlike in the Java version, argument p cannot be zero'
      elsif !(0.0..1.0).cover?(p)
        fail ArgumentError,
             "Probability argument p must lie in the range 0+..1 (#{p})."
      end

      (Math.log(uniform).ceil / Math.log(1.0 - p)).to_i
    end

    # Returns an integer from the poisson distribution.
    # @param mean [Numeric] the distribution parameter.
    #   This value must lie in the range (0.0...Float::Infinity).
    # @return [Integer] a positive integer.
    # @raise [ArgumentError] if the mean is <= 0.
    # @raise [ArgumentError] if the mean is infinite.
    def poisson(mean)
      fail ArgumentError, "Mean agrgument must be > 0 (#{mean})." if mean <= 0
      fail ArgumentError, 'Mean argument must be finite.' if mean.infinite?

      k = 0   # current integer
      p = 1.0 # probability of current integer
      l = Math.exp(-mean)

      loop do
        k += 1
        p *= uniform

        return k - 1 if p < l
      end
    end

    # @overload pareto
    #   Returns a random float from the standard Pareto distribution.
    #   @return [Float]
    # @overload pareto(alpha)
    #   Returns a random float from a Pareto distribution with shape
    #   parameter alpha.
    #   @param alpha [Numeric] the shape parameter of the distribution.
    #   @return [Float]
    def pareto(alpha = 1.0)
      unless alpha > 0.0
        fail ArgumentError,
             "Shape parameter alpha must be positive (#{alpha})."
      end

      (1.0 - uniform)**(-1.0 / alpha) - 1.0
    end

    # Returns a random float from an exponential distribution.
    # @param rate [Numeric] the rate of the exponential.
    # @return [Float]
    # @raise [ArgumentError] if rate <= 0
    def exponential(rate)
      if rate <= 0.0
        fail ArgumentError, "Rate parameter must be positive (#{rate})."
      end

      -Math.log(1.0 - uniform) / rate
    end

    # Returns a random float from the Cauchy distribution.
    # @return [Float]
    def cauchy
      Math.tan(Math::PI * (uniform - 0.5))
    end

    # Returns a random integer based on the probability of the occurence of
    # each integer.
    # @param  weights [Array<Float>] probability of occurence.
    # @return [Integer] an index into the given distribution.
    # @raise [ArgumentError] if any of the weights is negative.
    # @raise [ArgumentError] if the weights do not sum to (almost) 1.0.
    def discrete_probabilities(weights)
      fail_if_has_negative_elements(weights)
      fail_unless_sum_to_1(weights)

      loop do
        r = uniform
        sum = 0
        weights.each_with_index do |weight, index|
          sum += weight
          return index if sum > r
        end
      end
    end

    # Returns a random index based on a uniform distribution weighted by the
    # frequencies given.
    # @param frequencies [Array<Integer>] frequency of occurence.
    # @return [Integer] index into the distribution.
    # @raise [ArgumentError] if the array has negative elements.
    # @raise [ArgumentError] if the array has no non-zero elements.
    def discrete_frequencies(frequencies)
      fail_if_has_negative_elements(frequencies)
      fail_unless_has_non_zero_elements(frequencies)

      sum = frequencies.inject(:+)
      r = uniform(sum)

      sum = 0
      frequencies.each_with_index do |f, index|
        sum += f
        return index if sum > r
      end
    end

    # @overload shuffle(array)
    #   Returns a copy of array where all the elements have been shuffles in
    #   uniformly random order.
    #   @param array [Array] the array to shuffle.
    #   @return [Array] a shuffled array.
    # @overload shuffle(array, range)
    #   Returns a copy of array, where all the elements in the sub-array, whose
    #   indices are described by range, have been shuffled in uniformly random
    #   order.
    #   @param array [Array] the array to shuffle.
    #   @param range [Range<Integer>] the range of indices of the sub-array.
    #   @return [Array] a partly shuffled array.
    #   @raise [RangeError] if the given range is not a valid sub-array. Note
    #     that negative indices are not allowed!
    def shuffle(array, range = 0...array.size)
      shuffle!(array.dup, range)
    end

    # @overload shuffle(array)
    #   Shuffles the elements of array in place in uniformly random order.
    #   @param array [Array] the array to shuffle.
    #   @return [Array] a shuffled array.
    # @overload shuffle(array, range)
    #   Shuffles the elements of array[range] in place in uniformly random
    #   order.
    #   @param array [Array] the array to shuffle.
    #   @param range [Range<Integer>] the range of indices of the sub-array.
    #   @return [Array] a partly shuffled array.
    #   @raise [RangeError] if the given range is not a valid sub-array. Note
    def shuffle!(array, range = 0...array.size)
      if range.min && range.min < 0
        fail RangeError, "The subarray range is invalid (#{range})."
      elsif range.max && range.max >= array.size
        fail RangeError, "The subarray range is invalid (#{range})."
      end

      range.each do |i|
        r = i + uniform(range.max - i + 1) # Between i and high
        temp = array[i]
        array[i] = array[r]
        array[r] = temp
      end

      array
    end

    private

    # Raises an ArgumentError if array has any negative elements.
    # @param array [Array<Numeric>]
    # @return [void]
    # @raise [ArgumentError] if any array element is negative.
    def fail_if_has_negative_elements(array)
      return unless (i = array.find_index { |x| x < 0 })

      fail ArgumentError,
           "Array entry #{i} must be nonnegative (#{array[i]})."
    end

    # Raises an ArgumentError if array has no non-zero elements.
    # @param array [Array<Numeric>]
    # @return [void]
    # @raise [ArgumentError] if no element is non-zero.
    def fail_unless_has_non_zero_elements(array)
      return if array.any? { |x| x != 0 }

      fail ArgumentError,
           'At least one element must be non-zero.'
    end

    # Raises an ArgumentError if the elements of the array do not sum to
    # (almost) 1.0
    # @param array [Array<Numeric>]
    # @return [void]
    # @raise [ArgumentError] if the array does not sum to 1.0.
    def fail_unless_sum_to_1(array)
      epsilon = 1e-14
      sum = array.inject(0, :+)

      if (1.0 - sum).abs > epsilon
        fail ArgumentError,
             "Sum of elements does not approximately equal 1 (#{sum})."
      end
    end
  end

  # Testing client
  if __FILE__ == $PROGRAM_NAME
    n = ARGV.shift.to_i
    seed = ARGV.shift

    StandardRandom.seed = seed.to_i if seed

    probabilities = [0.5, 0.3, 0.1, 0.1]
    frequencies = [5, 3, 1, 1]
    symbols = [:a, :b, :c, :d, :e, :f, :g]

    puts "Seed: #{StandardRandom.seed}"
    n.times do
      puts [StandardRandom.uniform(100),
            StandardRandom.uniform(10.0..99.0),
            StandardRandom.bernoulli(0.5),
            StandardRandom.gaussian(9.0, 0.2),
            StandardRandom.discrete_probabilities(probabilities),
            StandardRandom.discrete_frequencies(frequencies)].join(' ')
    end
    puts "Before shuffling: \t#{symbols}"
    puts "After shuffling: \t#{StandardRandom.shuffle(symbols)}"
  end
end

###############################################################################
# The code in this file is based on the java code in StdRandom from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# standard_random.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# standard_random.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with standard_random.rb.  If not, see http://www.gnu.org/licenses.
################################################################################

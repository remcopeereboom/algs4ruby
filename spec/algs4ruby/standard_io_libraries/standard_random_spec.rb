require 'spec_helper'

module Algs4Ruby
  describe StandardRandom do
    describe '.rng' do
      it 'returns a handle to a global StandardRandom instance' do
        expect(StandardRandom.rng).to be_a StandardRandom
        expect(StandardRandom.rng).to eq StandardRandom.rng
      end
    end

    describe '.new' do
      context 'given a seed' do
        let(:seed) { 10 }

        it 'returns a new StandardRandom instance with the given seed' do
          rng = StandardRandom.new(seed)

          expect(rng).to be_a StandardRandom
          expect(rng.seed).to eq seed
        end
      end

      context 'not given a seed' do
        it 'returns a new StandardRandom instance with a random seed' do
          rng1 = StandardRandom.new
          rng2 = StandardRandom.new

          expect(rng1).to be_a StandardRandom
          expect(rng2).to be_a StandardRandom

          expect(rng1.seed).to_not eq rng2.seed
        end
      end
    end

    describe '#seed' do
      let(:rng) { StandardRandom.new }

      it 'returns an integer' do
        expect(rng.seed).to be_an Integer
      end

      it 'does not modify the seed' do
        expect(rng.seed).to eq rng.seed
      end
    end

    describe '#seed=' do
      let(:rng) { StandardRandom.new }

      it 'sets the seed of the rng' do
        # Make sure we NEVER fail
        if rng.seed == 10
          rng.seed = 20
          expect(rng.seed).to eq 20
        else
          rng.seed = 10
          expect(rng.seed).to eq 10
        end
      end
    end

    describe '#uniform' do
      let(:rng) { StandardRandom.new }

      context 'given no arguments' do
        it 'returns a random float drawn uniformly from  0...1' do
          10.times { expect(rng.uniform).to be_a Float }
        end
      end

      context 'given a number n >= 1' do
        it 'returns a random integer drawn uniformly from 0...n' do
          (1..10).each do |n|
            q = rng.uniform(n)
            expect(q).to be_an Integer
            expect(0...n).to cover q
          end
        end
      end

      context 'given a number n <= 0' do
        it 'raises an ArgumentError' do
          expect { rng.uniform(0) }.to raise_error ArgumentError
          expect { rng.uniform(-1) }.to raise_error ArgumentError
        end
      end

      context 'given a number 0 < n < 1' do
        it 'returns a random float drawn uniformly from 0...1' do
          10.times do
            q = rng.uniform(rand(0.1...1))
            expect(q).to be_a Float
            expect(0...1).to cover q
          end
        end
      end

      context 'given a range of floats' do
        let(:range) { 2.3..5.5 }

        it 'returns a random float drawn uniformly from the given range' do
          q = rng.uniform(range)
          expect(q).to be_a Float
          expect(range).to cover q
        end
      end

      context 'given a range of integers' do
        let(:range) { -23..-12 }
        it 'returns a random integer drawn uniformly from the given range' do
          q = rng.uniform(range)
          expect(q).to be_a Integer
          expect(range).to cover q
        end
      end
    end

    describe 'bernoulli' do
      let(:rng) { StandardRandom.new }

      context 'given a probability < 0' do
        let(:p) { -0.1 }

        it 'raises an ArgumentError' do
          expect { rng.bernoulli(p) }.to raise_error ArgumentError
        end
      end

      context 'given a probability > 1' do
        let(:p) { 1.1 }

        it 'raises an ArgumentError' do
          expect { rng.bernoulli(p) }.to raise_error ArgumentError
        end
      end

      context 'given a probability of 0' do
        let(:p) { 0 }

        it 'returns false' do
          expect(rng.bernoulli(p)).to be false
        end
      end

      context 'given a probability of 1' do
        let(:p) { 1 }

        it 'returns true' do
          expect(rng.bernoulli(p)).to be true
        end
      end

      context 'given a probability between 0 and 1' do
        let(:p) { rand 0.0..1.0 }

        it 'returns a boolean' do
          expect(rng.bernoulli(p)).to be(true).or be(false)
        end
      end

      context 'given no arguments' do
        it 'assumes a probability of 0.5' do
          expect(rng.bernoulli).to be(true).or be(false)
        end
      end
    end

    describe '#gaussian' do
      let(:rng) { StandardRandom.new }

      context 'given no arguments' do
        it 'returns a random float from the standard normal distribution' do
          expect(rng.gaussian).to be_a Float
        end
      end

      context 'given a mean and a standard deviation of 0' do
        let(:mean) { 10.0 }
        let(:stddev) { 0.0 }

        it 'returns the mean' do
          expect(rng.gaussian(mean, stddev)).to eq mean
        end
      end

      context 'given a mean and a standard deviation' do
        let(:mean) { rand(-1000.0...1000.0) }
        let(:stddev) { rand 100.0 }

        it 'returns a random float from the specified normal distribution' do
          expect(rng.gaussian(mean, stddev)).to be_a Float
        end
      end
    end

    describe '#geometric' do
      let(:rng) { StandardRandom.new }

      context 'given a distribution probability parameter p < 0' do
        let(:p) { -0.1 }

        it 'raises an ArgumentError' do
          expect { rng.geometric(p) }.to raise_error ArgumentError
        end
      end

      context 'given a distribution probability parameter p > 1' do
        let(:p) { 1.1 }

        it 'raises an ArgumentError' do
          expect { rng.geometric(p) }.to raise_error ArgumentError
        end
      end

      context 'given a distribution probability parameter p = 0' do
        let(:p) { 0 }

        it 'raises an ArgumentError' do
          expect { rng.geometric(p) }.to raise_error ArgumentError
        end
      end

      context 'given a distribution probability parameter p = 1' do
        let(:p) { 1 }

        it 'returns 0' do
          expect(rng.geometric(p)).to eq 0
        end
      end

      context 'given a distribution probability parameter 0 < p < 1' do
        let(:p) { rand 0.0..1.0 }

        it 'returns a random integer' do
          expect(rng.geometric(p)).to be_a Integer
        end
      end
    end

    describe '#poisson' do
      let(:rng) { StandardRandom.new }

      context 'given mean < 0' do
        let(:mean) { -rand(1000) }

        it 'raises an ArgumentError' do
          expect { rng.poisson(mean) }.to raise_error ArgumentError
        end
      end

      context 'given a mean of 0' do
        let(:mean) { -rand(1000) }

        it 'raises an ArgumentError' do
          expect { rng.poisson(mean) }.to raise_error ArgumentError
        end
      end

      context 'given an infinite mean' do
        let(:mean) { -rand(10) }

        it 'raises an ArgumentError' do
          expect { rng.poisson(mean) }.to raise_error ArgumentError
        end
      end

      context 'given a mean such that 0 < mean < Float::INFINITY' do
        let(:mean) { 0.1 + rand(10) }

        it 'returns a random integer from the given distribution' do
          expect(rng.poisson(mean)).to be_an Integer
        end
      end
    end

    describe '#pareto' do
      let(:rng) { StandardRandom.new }

      context 'given no arguments' do
        it 'returns a random number from the standard Pareto distribution' do
          expect(rng.pareto).to be_a Float
        end
      end

      context 'given a shape parameter <= 0' do
        let(:alpha) { 0 }

        it 'raises an ArgumentError' do
          expect { rng.pareto(alpha) }.to raise_error ArgumentError
        end
      end

      context 'given a shape parameter > 0' do
        let(:alpha) { 3.5 }

        it 'returns a random number from the given Pareto distribution' do
          expect(rng.pareto(alpha)).to be_a Float
        end
      end
    end

    describe '#exponential' do
      let(:rng) { StandardRandom.new }

      context 'given a rate <= 0' do
        let(:rate) { 0.0 }

        it 'raises an ArgumentError' do
          expect { rng.exponential(rate) }.to raise_error ArgumentError
        end
      end

      context 'given a valid rate' do
        let(:rate) { 2.3 }

        it 'returns a random float from the given distribution' do
          expect(rng.exponential(rate)).to be_a Float
        end
      end
    end

    describe '#cauchy' do
      let(:rng) { StandardRandom.new }

      it 'returns a float from the cauchy distribution' do
        expect(rng.cauchy).to be_a Float
      end
    end

    describe '#discrete' do
      let(:rng) { StandardRandom.new }

      context 'given entries that do not sum to almost 1.0' do
        let(:ps) { [0.4, 0.4] }

        it 'raises an ArgumentError' do
          expect { rng.discrete_probabilities(ps) }.to raise_error ArgumentError
        end
      end

      context 'given entries that are not all >= 0' do
        let(:ps) { [0.5, 0.5, 0.1, -0.1] }

        it 'raises an ArgumentError' do
          expect { rng.discrete_probabilities(ps) }.to raise_error ArgumentError
        end
      end

      context 'given an empty array' do
        let(:ps) { [] }

        it 'raises an ArgumentError' do
          expect { rng.discrete_probabilities(ps) }.to raise_error ArgumentError
        end
      end

      context 'given an array of all-0-entries and one 1-entry' do
        let(:ps) { [0, 0, 0, 0, 1].shuffle }

        it 'returns the index of the 1-entry' do
          expect(rng.discrete_probabilities(ps)).to eq ps.find_index(1)
        end
      end

      context 'given an array of probabilities that sum to 1' do
        let(:ps) { [0.1, 0.1, 0.2, 0.3, 0.2, 0.1] }
        let(:range) { 0..(ps.size) }

        it 'returns an index into the array' do
          expect(range).to cover rng.discrete_probabilities ps
        end
      end
    end

    describe '#discrete_frequencies' do
      let(:rng) { StandardRandom.new }

      context 'given an empty array of frequencies' do
        let(:fs) { [] }

        it 'raises an ArgumentError' do
          expect { rng.discrete_frequencies(fs) }.to raise_error ArgumentError
        end
      end

      context 'given an array of all-zero frequencies' do
        let(:fs) { [0, 0, 0, 0, 0, 0] }

        it 'raises an ArgumentError' do
          expect { rng.discrete_frequencies(fs) }.to raise_error ArgumentError
        end
      end

      context 'given an array with a negative frequency' do
        let(:fs) { [-1, 0, 1, 2, 3, 4, 5] }

        it 'raises an ArgumentError' do
          expect { rng.discrete_frequencies(fs) }.to raise_error ArgumentError
        end
      end

      context 'given an array with one non-zero frequency' do
        let(:fs) { [0, 0, 0, 0, 1].shuffle }
        let(:index) { fs.find_index { |x| x != 0 } }

        it 'returns the index of the non-zero frequency' do
          expect(rng.discrete_frequencies(fs)).to eq index
        end
      end

      context 'given an array with at least one non-zero frequency' do
        let(:fs) { [0, 1, 2, 3, 4, 5, 6] }
        let(:range) { 0...fs.size }

        it 'returns an index into the array' do
          expect(range).to cover rng.discrete_frequencies(fs)
        end
      end
    end

    describe '#shuffle' do
      let(:rng) { StandardRandom.new }

      context 'given an empty array' do
        let(:array) { [] }

        it 'returns a new array instance' do
          expect(rng.shuffle(array)).to_not be array
        end

        it 'returns an empty array' do
          expect(rng.shuffle(array)).to eq []
        end
      end

      context 'given an arbitrary array and an invalid range' do
        let(:array) { [0, 1, 2, 3, 4] }
        let(:range) { -1..3 }

        it 'raises an ArgumentError' do
          expect { rng.shuffle(array, range) }.to raise_error RangeError
        end
      end

      context 'given an arbitrary array and a valid range' do
        let(:array) { Array.new(100) { |i| i } }
        let(:range) { 10..90 }
        let(:left) { 0...10 }
        let(:right) { 91...100 }

        it 'shuffles the elements in the sub-array' do
          shuffled = rng.shuffle(array, range)
          expect(shuffled[range]).to_not eq array[range]
        end

        it 'does not shuffle the elements outside the sub-array' do
          shuffled = rng.shuffle(array, range)
          expect(shuffled[left]).to eq array[left]
          expect(shuffled[right]).to eq array[right]
        end

        it 'does not mutate the source array' do
          expect(rng.shuffle(array, range)).to_not be array
        end
      end
    end

    describe '#shuffle!' do
      let(:rng) { StandardRandom.new }

      context 'given an empty array' do
        let(:array) { [] }

        it 'returns an empty array' do
          expect(rng.shuffle!(array)).to eq []
        end
      end

      context 'given an arbitrary array and an invalid range' do
        let(:array) { [0, 1, 2, 3, 4] }
        let(:range) { -1..3 }

        it 'raises an ArgumentError' do
          expect { rng.shuffle!(array, range) }.to raise_error RangeError
        end
      end

      context 'given an arbitrary array and a valid range' do
        let(:array) { Array.new(100) { |i| i } }
        let(:range) { 10..90 }
        let(:left) { 0...10 }
        let(:right) { 91...100 }

        it 'shuffles the elements in the sub-array' do
          shuffled = rng.shuffle!(array.dup, range)
          expect(shuffled[range]).to_not eq array[range]
        end

        it 'does not shuffle the elements outside the sub-array' do
          shuffled = rng.shuffle!(array.dup, range)
          expect(shuffled[left]).to eq array[left]
          expect(shuffled[right]).to eq array[right]
        end

        it 'mutates the source array' do
          copy = array.dup

          rng.shuffle!(array, range)

          expect(array).to_not eq copy
        end
      end
    end
  end
end

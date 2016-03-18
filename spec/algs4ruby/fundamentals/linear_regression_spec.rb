require 'spec_helper'

module Algs4Ruby
  describe LinearRegression do
    describe '#initialize' do
      context 'given two arrays of unequal length' do
        let(:xs) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }
        let(:ys) { [1, 2, 3, 4, 5] }

        it 'raises an ArgumentError' do
          expect { LinearRegression.new(xs, ys) }.to raise_error ArgumentError
        end
      end

      context 'given two arrays of equal length' do
        let(:xs) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }
        let(:ys) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }

        it 'returns a LinearRegression object' do
          expect(LinearRegression.new(xs, ys)).to be_a LinearRegression
        end
      end
    end

    describe '#intercept' do
      context 'given the line y = c' do
        let(:c) { rand 10 }
        let(:xs) { Array 1..10 }
        let(:ys) { xs.map { c } }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns c' do
          expect(lr.intercept).to eq c
        end
      end

      context 'given the line x = c' do
        let(:c) { rand 10 }
        let(:ys) { Array 1..10 }
        let(:xs) { ys.map { c } }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns a float that is not finite' do
          expect(lr.intercept).to_not be_finite
        end
      end

      context 'given the line y = x' do
        let(:a) { 0 }
        let(:b) { 0 }
        let(:xs) { Array 1..10 }
        let(:ys) { xs.map { |x| a * x + b } }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns 0' do
          expect(lr.intercept).to eq 0
        end
      end

      context 'given the line y = ax + b' do
        let(:a) { rand(-10..10) }
        let(:b) { rand(-10..10) }
        let(:xs) { Array 1..10 }
        let(:ys) { xs.map { |x| a * x + b } }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns b' do
          expect(lr.intercept).to eq b
        end
      end
    end

    describe '#slope' do
      context 'given the line y = c' do
        let(:c) { rand(1..10) }
        let(:xs) { Array 1..10 }
        let(:ys) { xs.map { c } }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns 0' do
          expect(lr.slope).to eq 0
        end
      end

      context 'given the line x = c' do
        let(:c) { rand 10 }
        let(:ys) { Array 1..10 }
        let(:xs) { ys.map { c } }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns a float that is not finite' do
          expect(lr.slope).to_not be_finite
        end
      end

      context 'given the line y = x' do
        let(:a) { 1 }
        let(:b) { 0 }
        let(:xs) { Array 1..10 }
        let(:ys) { xs.map { |x| a * x + b } }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns 1' do
          expect(lr.slope).to eq 1
        end
      end

      context 'given the line y = ax + b' do
        let(:a) { rand(-10..10) }
        let(:b) { rand(-10..10) }
        let(:xs) { Array 1..10 }
        let(:ys) { xs.map { |x| a * x + b } }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns a' do
          expect(lr.slope).to eq a
        end
      end
    end

    describe '#r2' do
      context 'for a set of no points' do
        let(:xs) { [] }
        let(:ys) { [] }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns NaN' do
          expect(lr.r2).to be_nan
        end
      end

      context 'for a perfectly straight line' do
        let(:xs) { [1, 2, 3, 4, 5] }
        let(:ys) { [1, 2, 3, 4, 5] }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns 1' do
          expect(lr.r2).to eq 1
        end
      end

      context 'for a large set of random data' do
        let(:xs) { Array 1..1000 }
        let(:ys) { Array.new(1000) { rand 1000 } }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns a value close to 0' do
          expect(lr.r2).to be_within(0.1).of 0
        end
      end
    end

    describe '#intercept_std_err' do
      context 'for a set of fewer than 3 points' do
        let(:xs) { [1, 2] }
        let(:ys) { [1, 2] }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns NaN' do
          expect(lr.intercept_std_err).to be_nan
        end
      end

      context 'for a perfectly straight line with many points' do
        let(:xs) { Array 1...1000 }
        let(:ys) { xs.map { |x| x / xs.size } }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns a relatively small value' do
          expect(lr.intercept_std_err).to be < 0.001
        end
      end
    end

    describe '#slope_std_err' do
      context 'for a set of fewer than 3 points' do
        let(:xs) { [1, 2] }
        let(:ys) { [1, 2] }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns NaN' do
          expect(lr.slope_std_err).to be_nan
        end
      end
    end

    describe '#predict' do
      context 'given the line y = x' do
        let(:xs) { [1, 2, 3, 4, 5] }
        let(:ys) { [1, 2, 3, 4, 5] }
        let(:lr) { LinearRegression.new(xs, ys) }

        it 'returns y for each value of x' do
          expect(lr.predict(0)).to be_within(0.01).of 0
          expect(lr.predict(6)).to be_within(0.01).of 6
        end
      end
    end
  end
end

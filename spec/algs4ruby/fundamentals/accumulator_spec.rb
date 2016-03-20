require 'spec_helper'

module Algs4Ruby
  describe Accumulator do
    describe '#initialize' do
      let(:acc) { Accumulator.new }

      it 'has a count of zero' do
        expect(acc.count).to be_zero
      end

      it 'has a mean of zero' do
        expect(acc.mean).to be_zero
      end

      it 'has a variance of zero' do
        expect(acc.var).to be_zero
      end

      it 'has a standard deviation of zero' do
        expect(acc.stddev).to be_zero
      end
    end

    describe '#add_data_value(x)' do
      let(:acc) { Accumulator.new }
      let(:values) { Array.new(10) { rand(-10.0..10.0) } }

      context 'when adding a value' do
        it 'increments the count by 1' do
          expect(acc.count).to eq 0
          values.each_with_index do |x, i|
            acc.add_data_value(x)
            expect(acc.count).to eq 1 + i
          end
        end

        it 'updates the mean' do
          (0...values.size).each do |i|
            acc.add_data_value(values[i])
            actual_mean = values[0..i].inject(:+) / (i + 1)
            expect(acc.mean).to be_within(0.01).of actual_mean
          end
        end
      end
    end
  end
end

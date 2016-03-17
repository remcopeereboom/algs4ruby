require 'spec_helper'

module Algs4Ruby
  describe Counter do
    describe '#initialize' do
      context 'given an id' do
        let(:id) { 'foo' }

        it 'has a tally of 0' do
          expect(Counter.new(id).tally).to eq 0
        end
      end
    end

    describe '#increment' do
      let(:counter) { Counter.new('foo') }

      it 'increments the tally by 1' do
        expect(counter.tally).to eq 0

        counter.increment
        expect(counter.tally).to eq 1

        counter.increment
        expect(counter.tally).to eq 2
      end
    end

    describe '#<=>' do
      let(:lhs) do
        lhs = Counter.new('lhs')
        5.times { lhs.increment }
        lhs
      end

      context 'given a counter with a smaller tally' do
        let(:rhs) do
          rhs = Counter.new('rhs')
          (lhs.count - 1).times { rhs.increment }
          rhs
        end

        it 'returns a positive number' do
          expect(lhs <=> rhs).to be > 0
        end
      end

      context 'given a counter with the same tally' do
        let(:rhs) do
          rhs = Counter.new('rhs')
          lhs.count.times { rhs.increment }
          rhs
        end

        it 'returns 0' do
          expect(lhs <=> rhs).to be 0
        end
      end

      context 'given a counter with a larger tally' do
        let(:rhs) do
          rhs = Counter.new('rhs')
          (lhs.count + 1).times { rhs.increment }
          rhs
        end

        it 'returns a negative number' do
          expect(lhs <=> rhs).to be < 0
        end
      end
    end

    describe '#to_s' do
      let(:id) { 'foo' }
      let(:counter) { Counter.new(id) }

      it 'returns a string that contains the count' do
        expect(counter.to_s).to include(counter.count.to_s)
      end

      it 'returns a string that contains the id' do
        expect(counter.to_s).to include(id)
      end
    end
  end
end

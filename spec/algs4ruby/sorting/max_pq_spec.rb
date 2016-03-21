require 'spec_helper'

module Algs4Ruby
  describe MaxPQ do
    describe '#initialize' do
      context 'given no arguments' do
        it 'returns an empty queue' do
          expect(MaxPQ.new).to be_empty
        end
      end

      context 'given a reserved capacity less than 0' do
        it 'raises an ArgumentError' do
          expect { MaxPQ.new(0) }.to raise_error ArgumentError
        end
      end

      context 'given a valid reserved capacity' do
        let(:capacity) { rand(1..10) }

        it 'returns an empty queue' do
          expect(MaxPQ.new(capacity)).to be_empty
        end
      end

      context 'given an empty collection' do
        let(:items) { [] }
        let(:pq) { MaxPQ.new(items) }

        it 'returns an empty queue' do
          expect(pq).to be_empty
        end
      end

      context 'given a collection of n items' do
        let(:items) { %i(foo bar baz crux).shuffle }
        let(:pq) { MaxPQ.new(items) }

        it 'returns a queue with n items' do
          expect(pq.size).to eq items.size
        end

        it 'returns a queue that contains the items' do
          expect(items.all? { |x| pq.include?(x) }).to be_truthy
        end
      end
    end

    describe '#empty?' do
      context 'called on an empty pq' do
        let(:pq) { MaxPQ.new }

        it 'returns the literal true  (i.e. not just truthy)' do
          expect(pq.empty?).to be true
        end
      end

      context 'called on a non-empty pq' do
        let(:items) { %i(foo bar baz crux).shuffle }
        let(:pq) { MaxPQ.new(items) }

        it 'returns the literal false (i.e. not just falsey)' do
          expect(pq.empty?).to be false
        end
      end
    end

    describe '#max' do
      context 'called on an empty pq' do
        let(:pq) { MaxPQ.new }

        it 'raises a PriorityQueueEmptyError' do
          expect(pq).to be_empty
          expect { pq.max }.to raise_error PriorityQueueEmptyError
        end
      end

      context 'given a pq with items' do
        let(:items) { %i(foo bar baz crux).shuffle }
        let(:pq) { MaxPQ.new(items) }

        it 'returns the smallest item' do
          expect(pq.max).to eq items.max
        end

        it 'does not remove the item from the pq' do
          size_before = pq.size
          item_before = pq.max

          expect(pq.max).to eq item_before
          expect(pq.size).to eq size_before
        end
      end
    end

    describe '#delete_max' do
      context 'given an empty pq' do
        let(:pq) { MaxPQ.new }

        it 'raises a PriorityQueueEmptyError' do
          expect(pq).to be_empty
          expect { pq.delete_max }.to raise_error PriorityQueueEmptyError
        end
      end

      context 'given a pq with items' do
        let(:items) { %i(foo bar baz crux).shuffle }
        let(:pq) { MaxPQ.new(items) }

        it 'returns the smallest item' do
          n = items.size
          items.sort!
          n.times { expect(pq.delete_max).to eq items.pop }
        end

        it 'lowers the number of items by 1' do
          n = items.size
          n.downto(1) do |i|
            expect(pq.size).to eq i
            pq.delete_max
            expect(pq.size).to eq i - 1
          end
        end
      end
    end

    describe '#insert' do
      context 'given an item' do
        let(:items) { %i(foo bar baz crux).shuffle }
        let(:pq) { MaxPQ.new }

        it 'increases the size of the pq by 1' do
          items.each_with_index do |x, i|
            expect(pq.size).to eq i
            pq.insert(x)
            expect(pq.size).to eq i + 1
          end
        end

        it 'adds the item to the pq' do
          items.each do |x|
            pq.insert(x)
            expect(pq.include?(x)).to be true
          end
        end
      end
    end
  end
end

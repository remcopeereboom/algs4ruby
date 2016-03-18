module Algs4Ruby
  RSpec.shared_examples 'a queue' do
    describe '#initialize' do
      it 'creates an empty queue' do
        expect(described_class.new).to be_empty
      end
    end

    describe 'enqueue' do
      let(:queue) { described_class.new }
      let(:items) { %i(foo bar baz crux) }

      it 'adds the item to the queue' do
        expect(queue).to be_empty

        n = items.size
        n.times do |i|
          queue.enqueue items.unshift
          expect(queue.size).to eq i + 1
        end
      end
    end

    describe 'dequeue' do
      context 'given an empty queue' do
        let(:queue) { described_class.new }

        it 'raises a QueueEmptyError' do
          expect(queue).to be_empty
          expect { queue.dequeue }.to raise_error QueueEmptyError
        end
      end

      context 'given a non-empty queue' do
        let(:items) { %i(foo bar baz crux) }
        let(:queue) do
          items.each_with_object(described_class.new) { |i, s| s.enqueue i }
        end

        it 'returns the least recently added item' do
          n = items.size
          n.times { expect(queue.dequeue).to eq items.shift }
        end

        it 'removes the least recently added item from the queue' do
          n = items.size
          n.times do |i|
            queue.dequeue
            expect(queue.size).to eq(n - i - 1)
          end
        end
      end
    end

    describe 'peek' do
      let(:queue) { described_class.new }
      let(:items) { %i(foo bar baz crux) }

      context 'given an empty queue' do
        it 'raises a QueueEmptyError' do
          expect(queue).to be_empty
          expect { queue.dequeue }.to raise_error QueueEmptyError
        end
      end

      context 'given a non-empty queue' do
        let(:items) { %i(foo bar baz crux) }
        let(:queue) do
          items.each_with_object(described_class.new) { |i, s| s.enqueue i }
        end

        it 'returns the least recently added item' do
          n = items.size
          n.times { expect(queue.peek).to eq items.first }
        end

        it 'doesn\'t change the size of the queue' do
          n = items.size
          n.times do
            queue.peek
            expect(queue.size).to eq n
          end
        end
      end
    end

    describe '#each' do
      let(:items) { %i(foo bar baz crux) }
      let(:queue) do
        items.each_with_object(described_class.new) { |i, s| s.enqueue i }
      end

      context 'not given a block' do
        it 'returns an enumerator to the items in FIFO order' do
          enum = queue.each

          n = items.size
          n.times { expect(enum.next).to eq items.shift }

          expect { enum.next }.to raise_error StopIteration
        end
      end

      context 'given a block' do
        it 'yields the items in the queue in FIFO order' do
          expect { |b| queue.each(&b) }.to yield_successive_args(*items)
        end

        it 'returns self' do
          expect(queue.each {}).to eq queue
        end
      end
    end
  end
end

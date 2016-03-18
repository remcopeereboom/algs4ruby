module Algs4Ruby
  RSpec.shared_examples 'a stack' do
    describe '#initialize' do
      it 'creates an empty stack' do
        expect(described_class.new).to be_empty
      end
    end

    describe '#push' do
      let(:stack) { described_class.new }
      let(:item_1) { :foo }
      let(:item_2) { :bar }
      let(:item_3) { :baz }
      let(:item_4) { :crux }

      context 'given an item' do
        it 'increases the size of the stack by one' do
          expect(stack).to be_empty

          stack.push item_1
          expect(stack.count).to eq 1

          stack.push item_2
          expect(stack.count).to eq 2

          stack.push item_3
          expect(stack.count).to eq 3

          stack.push item_4
          expect(stack.count).to eq 4
        end
      end
    end

    describe '#pop' do
      context 'given a non-empty stack' do
        let(:items) { %i(foo bar baz crux) }
        let(:stack) do
          items.each_with_object(described_class.new) { |i, s| s.push i }
        end

        it 'returns the top most item' do
          expect(stack.pop).to eq items.pop
          expect(stack.pop).to eq items.pop
          expect(stack.pop).to eq items.pop
          expect(stack.pop).to eq items.pop
        end

        it 'reduces the size of the stack by one' do
          n = stack.count
          n.downto(1) do |i|
            expect(stack.count).to eq i
            stack.pop
            expect(stack.count).to eq i - 1
          end
        end
      end

      context 'given an empty stack' do
        let(:stack) { described_class.new }

        it 'throws an StackEmptyError' do
          expect { stack.pop }.to raise_error StackEmptyError
        end
      end
    end

    describe '#peek' do
      context 'given an empty stack' do
        let(:stack) { described_class.new }

        it 'throws an StackEmptyError' do
          expect { stack.pop }.to raise_error StackEmptyError
        end
      end

      context 'given a non-empty stack' do
        let(:items) { %i(foo bar baz crux) }
        let(:stack) do
          items.each_with_object(described_class.new) { |i, s| s.push i }
        end

        it 'returns the top most item' do
          expect(stack.peek).to eq items.last
          expect(stack.peek).to eq items.last
          expect(stack.peek).to eq items.last
          expect(stack.peek).to eq items.last
        end

        it 'does not change the size of the stack' do
          expect(stack.count).to eq items.count

          stack.peek
          expect(stack.count).to eq items.count

          stack.peek
          expect(stack.count).to eq items.count

          stack.peek
          expect(stack.count).to eq items.count

          stack.peek
          expect(stack.count).to eq items.count
        end
      end
    end

    describe '#each' do
      let(:items) { %i(foo bar baz crux) }
      let(:stack) do
        items.each_with_object(described_class.new) { |i, s| s.push i }
      end

      context 'given a block' do
        it 'yields the items in the stack in LIFO order' do
          expect { |b| stack.each(&b) }.to yield_successive_args(*items.reverse)
        end

        it 'returns self' do
          expect(stack.each {}).to be stack
        end
      end

      context 'not given a block' do
        it 'returns an enumerator to the items in LIFO order' do
          enum = stack.each
          expect(enum).to be_an Enumerator

          n = items.count
          n.times do
            expect(enum.next).to eq items.pop
          end

          expect { enum.next }.to raise_error StopIteration
        end
      end
    end
  end
end

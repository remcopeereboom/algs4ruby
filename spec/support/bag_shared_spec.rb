module Algs4Ruby
  RSpec.shared_examples 'a bag' do
    describe '#initialize' do
      it 'creates an empty bag' do
        expect(described_class.new).to be_empty
      end
    end

    describe '#add' do
      context 'given an empty bag and some items' do
        let(:bag) { described_class.new }
        let(:item_1) { :foo }
        let(:item_2) { :bar }
        let(:item_3) { :baz }
        let(:item_4) { :crux }

        it 'adds the item to the bag' do
          expect(bag).to be_empty

          bag.add(item_1)
          expect(bag.include?(item_1)).to be true

          bag.add(item_2)
          expect(bag.include?(item_2)).to be true

          bag.add(item_3)
          expect(bag.include?(item_3)).to be true

          bag.add(item_4)
          expect(bag.include?(item_4)).to be true
        end

        it 'increases the size of the bag by 1' do
          expect(bag).to be_empty

          bag.add(item_1)
          expect(bag.count).to eq 1

          bag.add(item_2)
          expect(bag.count).to eq 2

          bag.add(item_3)
          expect(bag.count).to eq 3

          bag.add(item_4)
          expect(bag.count).to eq 4
        end

        it 'can reference the same object multiple times' do
          expect(bag).to be_empty

          bag.add(item_1)
          expect(bag.count).to eq 1

          bag.add(item_1)
          expect(bag.count).to eq 2
        end
      end
    end

    describe '#each' do
      let(:items) { %i(foo bar baz crux) }
      let(:bag) do
        b = described_class.new
        items.each { |i| b.add i }
        b
      end

      context 'given a block' do
        it 'returns the bag' do
          expect(bag.each {}).to eq bag
        end

        it 'yields every item in the bag' do
          bag.each { |i| items.delete i }
          expect(items).to be_empty
        end
      end

      context 'not given a block' do
        it 'returns an Enumerator to the items' do
          enum = bag.each
          expect(enum).to be_an Enumerator

          items.count.times { items.delete enum.next }
          expect(items).to be_empty

          expect { enum.next }.to raise_error StopIteration
        end
      end
    end
  end
end

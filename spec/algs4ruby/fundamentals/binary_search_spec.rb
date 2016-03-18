require 'spec_helper'

module Algs4Ruby
  describe BinarySearch do
    describe '#initialize' do
      context 'given a key not in the sorted array' do
        let(:array) { [1, 2, 3, 4, 5] }
        let(:key) { 7 }

        it 'returns  -1' do
          expect(BinarySearch.index_of(array, key)).to eq -1
        end
      end

      context 'given a key in the sorted array' do
        let(:array) { [1, 2, 3, 4, 5] }
        let(:key) { 3 }

        it 'returns the index of the key' do
          expect(BinarySearch.index_of(array, key)).to eq 2
        end
      end

      context 'given a key found multiple times in the sorted array' do
        let(:array) { [1, 2, 3, 4, 5, 5] }
        let(:key) { 5 }

        it 'returns one of the indices' do
          expect(BinarySearch.index_of(array, key)).to eq(4).or 5
        end
      end
    end
  end
end

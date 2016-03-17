require 'spec_helper'

module Algs4Ruby
  describe ThreeSum do
    describe '.count' do
      context 'given an empty array' do
        let(:a) { [] }

        it 'returns 0' do
          expect(ThreeSum.count(a)).to eq 0
        end
      end

      context 'given an array of one number' do
        let(:a) { [ rand(-10..10) ] }

        it 'returns 0' do
          expect(ThreeSum.count(a)).to eq 0
        end
      end

      context 'given an array of two numbers that sum to 0' do
        let(:a) { [-3, 3] }

        it 'returns 0' do
          expect(ThreeSum.count(a)).to eq 0
        end
      end

      context 'given a triplet that does not sum to 0' do
        let(:a) { [1, -1, 0] }
        it 'returns 1' do
          expect(ThreeSum.count(a)).to eq 1
        end
      end

      context 'given [1, 2, 3]' do
        let(:a) { [1, 2, 3] }

        it 'returns 0' do
          expect(ThreeSum.count(a)).to eq 0
        end
      end

      context 'given an array with 2 possible triples' do
        let(:a) { [-1, -1, 0, 1] }

        it 'returns 2' do
          expect(ThreeSum.count(a)).to eq 2
        end
      end
    end
  end
end

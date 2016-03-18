module Algs4Ruby
  RSpec.shared_examples 'a disjoint-set' do
    describe '#initialize' do
      context 'given an invalid size' do
        let(:n) { -1 }

        it 'throws an ArgumentError' do
          expect { described_class.new(n) }.to raise_error ArgumentError
        end
      end

      context 'given a valid size' do
        let(:n) { 10 }

        it 'creates a set with n connected components' do
          expect(described_class.new(n).size).to eq n
        end
      end
    end

    describe '#size' do
      let(:n) { 10 }
      let(:ds) { described_class.new(n) }

      it 'returns the number of connected components' do
        (1...n).each do |i|
          ds.union(0, i)
          expect(ds.size).to eq n - i
        end
      end
    end

    describe '#union' do
      let(:n) { 10 }
      let(:ds) { described_class.new(n) }

      context 'given an index outside the range 0...size' do
        let(:index_1) { -1 }
        let(:index_2) { n }

        it 'throws a a RangeError' do
          expect { ds.union(0, index_1) }.to raise_error RangeError
          expect { ds.union(index_1, 0) }.to raise_error RangeError
          expect { ds.union(0, index_2) }.to raise_error RangeError
          expect { ds.union(index_2, 0) }.to raise_error RangeError
        end
      end

      context 'connecting two unconnected components' do
        it 'merges the connected components of the indices' do
          expect(ds.find(0) == ds.find(1)).to be false
          expect(ds.find(0) == ds.find(2)).to be false
          expect(ds.find(1) == ds.find(2)).to be false

          ds.union(0, 1)

          expect(ds.find(0) == ds.find(1)).to be true
          expect(ds.find(0) == ds.find(2)).to be false
          expect(ds.find(1) == ds.find(2)).to be false

          ds.union(0, 2)

          expect(ds.find(0) == ds.find(1)).to be true
          expect(ds.find(0) == ds.find(2)).to be true
          expect(ds.find(1) == ds.find(2)).to be true
        end

        it 'changes reduces the number of connected components by one' do
          expect(ds.size).to eq n

          ds.union(0, 1)

          expect(ds.size).to eq n - 1

          ds.union(0, 2)

          expect(ds.size).to eq n - 2
        end

      end

      context 'connecting two connected components' do
        it 'does nothing' do
          ds.union(0, 1)
          ds.union(0, 2)

          expect(ds.find(0) == ds.find(1)).to be true
          expect(ds.find(0) == ds.find(2)).to be true
          expect(ds.find(1) == ds.find(2)).to be true
          expect(ds.find(2) == ds.find(3)).to be false
          expect(ds.size).to eq n - 2

          ds.union(0, 1)

          expect(ds.find(0) == ds.find(1)).to be true
          expect(ds.find(0) == ds.find(2)).to be true
          expect(ds.find(1) == ds.find(2)).to be true
          expect(ds.find(2) == ds.find(3)).to be false
          expect(ds.size).to eq n - 2

          ds.union(0, 2)

          expect(ds.find(0) == ds.find(1)).to be true
          expect(ds.find(0) == ds.find(2)).to be true
          expect(ds.find(1) == ds.find(2)).to be true
          expect(ds.find(2) == ds.find(3)).to be false
          expect(ds.size).to eq n - 2
        end
      end
    end

    describe '#find' do
      let(:n) { 10 }
      let(:ds) { described_class.new(n) }

      context 'given an index outside the range 0...size' do
        let(:index_1) { -1 }
        let(:index_2) { n }

        it 'throws a a RangeError' do
          expect { ds.find(index_1) }.to raise_error RangeError
          expect { ds.find(index_2) }.to raise_error RangeError
        end
      end

      context 'given a set with no unions' do
        it 'returns a different connected component for each valid index' do
          expect(n.times.map { |i| ds.find i }.uniq.size).to eq n
        end
      end

      context 'given a non-empty set with all elements unioned' do
        before(:each) { n.times { |i| ds.union(0, i) } }

        it 'returns the same connected component for all valid indices' do
          expect(n.times.map { |i| ds.find i }.uniq.size).to eq 1
        end
      end
    end
  end
end

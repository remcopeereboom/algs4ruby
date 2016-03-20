module Algs4Ruby
  RSpec.shared_examples 'a sorting algorithm' do
    describe '#sort' do
      context 'given an empty array' do
        let(:unsorted) { [] }
        let(:sorted) { [] }

        it 'returns an empty array' do
          expect(described_class.sort(unsorted)).to eq sorted
        end

        it 'returns a copy' do
          expect(described_class.sort(unsorted)).to_not be unsorted
        end
      end

      context 'given a sorted array' do
        let(:unsorted) { [ 2, 4, 6, 8, 10, 21, 1233] }
        let(:sorted) { unsorted.sort }

        it 'sorts the array' do
          expect(described_class.sort(unsorted)).to eq sorted
        end

        it 'returns a copy' do
          expect(described_class.sort(unsorted)).to_not be sorted
        end
      end

      context 'given a reverse sorted array' do
        let(:unsorted) { [10, 9, 8, 7, 6, 5] }
        let(:sorted) { unsorted.sort }

        it 'sorts the array' do
          expect(described_class.sort(unsorted)).to eq sorted
        end

        it 'does not mutate the array' do
          described_class.sort(unsorted)
          expect(unsorted).to_not eq sorted
        end

        it 'returns a copy' do
          expect(described_class.sort(unsorted)).to_not be sorted
        end
      end

      context 'given an alternating array' do
        let(:unsorted) { [1, 10, 2, 9, 3, 8, 4, 7, 5, 6] }
        let(:sorted) { unsorted.sort }

        it 'sorts the array' do
          expect(described_class.sort(unsorted)).to eq sorted
        end

        it 'does not mutate the array' do
          described_class.sort(unsorted)
          expect(unsorted).to_not eq sorted
        end

        it 'returns a copy' do
          expect(described_class.sort(unsorted)).to_not be sorted
        end
      end

      context 'given a incrementing-decrementing array' do
        let(:unsorted) { [1, 3, 5, 7, 9, 8, 6, 4, 2] }
        let(:sorted) { unsorted.sort }

        it 'sorts the array' do
          expect(described_class.sort(unsorted)).to eq sorted
        end

        it 'does not mutate the array' do
          described_class.sort(unsorted)
          expect(unsorted).to_not eq sorted
        end

        it 'returns a copy' do
          expect(described_class.sort(unsorted)).to_not be sorted
        end
      end

      context 'given a decrementing-incrementing array' do
        let(:unsorted) { [9, 7, 5, 3, 1, 2, 4, 6, 7] }
        let(:sorted) { unsorted.sort }

        it 'sorts the array' do
          expect(described_class.sort(unsorted)).to eq sorted
        end

        it 'does not mutate the array' do
          described_class.sort(unsorted)
          expect(unsorted).to_not eq sorted
        end

        it 'returns a copy' do
          expect(described_class.sort(unsorted)).to_not be sorted
        end
      end

      context 'given an unsorted array of random elements' do
        let(:unsorted) { Array.new(20) { rand 20 } }
        let(:sorted) { unsorted.sort }

        it 'sorts the array' do
          expect(described_class.sort(unsorted)).to eq sorted
        end

        it 'does not mutate the array' do
          described_class.sort(unsorted)
          expect(unsorted).to_not eq sorted
        end

        it 'returns a copy' do
          expect(described_class.sort(unsorted)).to_not be sorted
        end
      end

      context 'given a huge array', slow_test: true do
        let(:unsorted) { Array.new(5000) { rand 20 } }
        let(:sorted) { unsorted.sort }


        it 'sorts the array' do
          expect(described_class.sort(unsorted)).to eq sorted
        end

        it 'does not mutate the array' do
          described_class.sort(unsorted)
          expect(unsorted).to_not eq sorted
        end

        it 'returns a copy' do
          expect(described_class.sort(unsorted)).to_not be sorted
        end
      end

      context 'given an unsorted array and a lower and a higher index' do
        let(:unsorted) { (1..20).to_a.shuffle }
        let(:slice) { 5..10 }
        let(:left_slice) { 1..4 }
        let(:right_slice) { 11..20 }
        let(:sorted) do
          xs = unsorted.dup
          xs[slice] = xs[slice].sort
          xs
        end

        it 'sorts the sub-array' do
          sa = described_class.sort(unsorted, slice)
          expect(sa[slice]).to eq sorted[slice]
        end

        it 'does not sort outside the sub-array' do
          sa = described_class.sort(unsorted, slice)
          expect(sa[left_slice]).to eq unsorted[left_slice]
          expect(sa[right_slice]).to eq unsorted[right_slice]
        end

        it 'does not mutate the array' do
          described_class.sort(unsorted, slice)
          expect(unsorted).to_not eq sorted
        end

        it 'returns a copy' do
          expect(described_class.sort(unsorted)).to_not be sorted
        end
      end

      context 'given a comparator block' do
        let(:unsorted) { Array.new(20) { rand 20 } }
        let(:comparator) { ->(a, b) { b <=> a } }
        let(:sorted) { unsorted.sort(&comparator) }

        it 'sorts according to the comparator' do
          expect(described_class.sort(unsorted, &comparator)).to eq sorted
        end

        it 'does not mutate the array' do
          described_class.sort(unsorted, &comparator)
          expect(unsorted).to_not eq sorted
        end

        it 'returns a copy' do
          expect(described_class.sort(unsorted, &comparator)).to_not be sorted
        end
      end
    end

    describe '#sort!' do
      context 'given an empty array' do
        let(:unsorted) { [] }
        let(:sorted) { [] }

        it 'returns an empty array' do
          expect(described_class.sort!(unsorted)).to eq sorted
        end

        it 'modifies the source array' do
          described_class.sort!(unsorted)
          expect(unsorted).to eq sorted
        end
      end

      context 'given a sorted array' do
        let(:unsorted) { [ 2, 4, 6, 8, 10, 21, 1233] }
        let(:sorted) { unsorted.sort }

        it 'sorts the array' do
          expect(described_class.sort!(unsorted)).to eq sorted
        end

        it 'modifies the source array' do
          described_class.sort!(unsorted)
          expect(unsorted).to eq sorted
        end
      end

      context 'given a reverse sorted array' do
        let(:unsorted) { [10, 9, 8, 7, 6, 5] }
        let(:sorted) { unsorted.sort }

        it 'sorts the array' do
          expect(described_class.sort!(unsorted)).to eq sorted
        end

        it 'modifies the source array' do
          described_class.sort!(unsorted)
          expect(unsorted).to eq sorted
        end
      end

      context 'given an alternating array' do
        let(:unsorted) { [1, 10, 2, 9, 3, 8, 4, 7, 5, 6] }
        let(:sorted) { unsorted.sort }

        it 'sorts the array' do
          expect(described_class.sort!(unsorted)).to eq sorted
        end

        it 'modifies the source array' do
          described_class.sort!(unsorted)
          expect(unsorted).to eq sorted
        end
      end

      context 'given a incrementing-decrementing array' do
        let(:unsorted) { [1, 3, 5, 7, 9, 8, 6, 4, 2] }
        let(:sorted) { unsorted.sort }

        it 'sorts the array' do
          expect(described_class.sort!(unsorted)).to eq sorted
        end

        it 'modifies the source array' do
          described_class.sort!(unsorted)
          expect(unsorted).to eq sorted
        end
      end

      context 'given a decrementing-incrementing array' do
        let(:unsorted) { [9, 7, 5, 3, 1, 2, 4, 6, 7] }
        let(:sorted) { unsorted.sort }

        it 'sorts the array' do
          expect(described_class.sort!(unsorted)).to eq sorted
        end

        it 'modifies the source array' do
          described_class.sort!(unsorted)
          expect(unsorted).to eq sorted
        end
      end

      context 'given an unsorted array of random elements' do
        let(:unsorted) { Array.new(20) { rand 20 } }
        let(:sorted) { unsorted.sort }

        it 'sorts the array' do
          expect(described_class.sort!(unsorted)).to eq sorted
        end

        it 'modifies the source array' do
          described_class.sort!(unsorted)
          expect(unsorted).to eq sorted
        end
      end

      context 'given a huge array', slow_test: true do
        let(:unsorted) { Array.new(5000) { rand 20 } }
        let(:sorted) { unsorted.sort }

        it 'sorts the array' do
          expect(described_class.sort!(unsorted)).to eq sorted
        end

        it 'modifies the source array' do
          described_class.sort!(unsorted)
          expect(unsorted).to eq sorted
        end
      end

      context 'given an unsorted array and a lower and a higher index' do
        let(:unsorted) { (1..20).to_a.shuffle }
        let(:slice) { 5..10 }
        let(:left_slice) { 1..4 }
        let(:right_slice) { 11..20 }
        let(:sorted) do
          xs = unsorted.dup
          xs[slice] = xs[slice].sort
          xs
        end

        it 'sorts the sub-array' do
          sa = described_class.sort!(unsorted, slice)
          expect(sa[slice]).to eq sorted[slice]
        end

        it 'does not sort outside the sub-array' do
          sa = described_class.sort!(unsorted, slice)
          expect(sa[left_slice]).to eq unsorted[left_slice]
          expect(sa[right_slice]).to eq unsorted[right_slice]
        end

        it 'modifies the source array' do
          described_class.sort!(unsorted)
          expect(unsorted).to eq sorted
        end
      end

      context 'given a comparator block' do
        let(:unsorted) { Array.new(20) { rand 20 } }
        let(:comparator) { ->(a, b) { b <=> a } }
        let(:sorted) { unsorted.sort(&comparator) }

        it 'sorts according to the comparator' do
          expect(described_class.sort!(unsorted, &comparator)).to eq sorted
        end

        it 'modifies the source array' do
          described_class.sort!(unsorted, &comparator)
          expect(unsorted).to eq sorted
        end
      end
    end
  end
end

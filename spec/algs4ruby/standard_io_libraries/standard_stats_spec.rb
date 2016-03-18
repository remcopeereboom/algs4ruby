require 'spec_helper'

module Algs4Ruby
  describe StandardStats do
    describe '.min' do
      context 'given an empty array' do
        it 'returns Float::INFINITY' do
          expect(StandardStats.min([])).to eq Float::INFINITY
        end
      end

      context 'given an array of numbers' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }

        it 'returns the minimum of the array' do
          expect(StandardStats.min(a)).to eq(-5.1)
        end
      end

      context 'given a low < 0' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }
        let(:low) { -1 }
        let(:high) { 3 }

        it 'raises a RangeError' do
          expect { StandardStats.min(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given a high >= array.size' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }
        let(:low) { 0 }
        let(:high) { a.size }

        it 'raises a RangeError' do
          expect { StandardStats.min(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given a low > high' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }
        let(:low) { 4 }
        let(:high) { 2 }

        it 'raises a RangeError' do
          expect { StandardStats.min(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given an array and a valid sub-array range' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }
        let(:low) { 2 }
        let(:high) { 3 }

        it 'returns the minimum of the sub-array' do
          expect(StandardStats.min(a, low, high)).to eq 5
        end
      end
    end

    describe '.max' do
      context 'given an empty array' do
        it 'returns -Float::INFINITY' do
          expect(StandardStats.max([])).to eq(-Float::INFINITY)
        end
      end

      context 'given an array of numbers' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }

        it 'returns the maximum of the array' do
          expect(StandardStats.max(a)).to eq 23
        end
      end

      context 'given a low < 0' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }
        let(:low) { -1 }
        let(:high) { 3 }

        it 'raises a RangeError' do
          expect { StandardStats.max(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given a high >= array.size' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }
        let(:low) { 0 }
        let(:high) { a.size }

        it 'raises a RangeError' do
          expect { StandardStats.max(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given a low > high' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }
        let(:low) { 4 }
        let(:high) { 2 }

        it 'raises a RangeError' do
          expect { StandardStats.max(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given an array and valid sub-array indices' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }
        let(:low) { 2 }
        let(:high) { 3 }

        it 'returns the maximum of the sub-array' do
          expect(StandardStats.max(a, low, high)).to eq 12.0
        end
      end
    end

    describe '.sum' do
      context 'given an empty array' do
        it 'returns 0' do
          expect(StandardStats.sum([])).to eq 0
        end
      end

      context 'given an array of numbers' do
        let(:a) { [1, 2, 3] }

        it 'returns the sum of the array' do
          expect(StandardStats.sum(a)).to eq 6
        end
      end

      context 'given a low < 0' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }
        let(:low) { -1 }
        let(:high) { 3 }

        it 'raises a RangeError' do
          expect { StandardStats.sum(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given a high >= array.size' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }
        let(:low) { 0 }
        let(:high) { a.size }

        it 'raises a RangeError' do
          expect { StandardStats.sum(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given a low > high' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }
        let(:low) { 4 }
        let(:high) { 2 }

        it 'raises a RangeError' do
          expect { StandardStats.sum(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given an array and valid sub-array indices' do
        let(:a) { [1, 2, 3, 4] }
        let(:low) { 1 }
        let(:high) { 2 }

        it 'returns the sum of the sub-array' do
          expect(StandardStats.sum(a, low, high)).to eq 5
        end
      end
    end

    describe '.mean' do
      let(:a) { [] }

      context 'given an empty array' do
        it 'returns NaN' do
          expect(StandardStats.mean(a)).to be Float::NAN
        end
      end

      context 'given an array of numbers' do
        let(:a) { [1, 2, 3] }

        it 'returns the mean of the array' do
          expect(StandardStats.mean(a)).to eq 2
        end
      end

      context 'given a low < 0' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }
        let(:low) { -1 }
        let(:high) { 3 }

        it 'raises a RangeError' do
          expect { StandardStats.mean(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given a high >= array.size' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }
        let(:low) { 0 }
        let(:high) { a.size }

        it 'raises a RangeError' do
          expect { StandardStats.mean(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given a low > high' do
        let(:a) { [1, 23, 5, 12.0, -5.1] }
        let(:low) { 4 }
        let(:high) { 2 }

        it 'raises a RangeError' do
          expect { StandardStats.mean(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given an array and valid sub-array indices' do
        let(:a) { [1, 2, 3, 4] }
        let(:low) { 1 }
        let(:high) { 2 }

        it 'returns the mean of the sub-array' do
          expect(StandardStats.mean(a, low, high)).to eq 2.5
        end
      end
    end

    describe '.var' do
      context 'given an empty array' do
        it 'returns NaN' do
          expect(StandardStats.var([])).to be Float::NAN
        end
      end

      context 'given an array of equal values' do
        let(:a) { [2, 2, 2, 2, 2] }

        it 'returns 0' do
          expect(StandardStats.var(a)).to eq 0
        end
      end

      context 'given an array of random values' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4] }

        it 'returns the sample variance of the array' do
          expect(StandardStats.var(a)).to eq 1.3
        end
      end

      context 'given a low < 0' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { -1 }
        let(:high) { 5 }

        it 'raises a RangeError' do
          expect { StandardStats.var(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given a high > array.size' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { 0 }
        let(:high) { 8 }

        it 'raises a RangeError' do
          expect { StandardStats.var(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given low > high' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { 4 }
        let(:high) { 2 }

        it 'raises a RangeError' do
          expect { StandardStats.var(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given an array and a valid low and high' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { 0 }
        let(:high) { 5 }

        it 'returns the sample variance of the sub-array' do
          expect(StandardStats.var(a, low, high)).to eq 1.3
        end
      end
    end

    describe '.varp' do
      context 'given an empty array' do
        it 'returns NaN' do
          expect(StandardStats.varp([])).to be Float::NAN
        end
      end

      context 'given an array of equal values' do
        let(:a) { [2, 2, 2, 2, 2] }

        it 'returns 0' do
          expect(StandardStats.varp(a)).to eq 0
        end
      end

      context 'given an array of random values' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4] }

        it 'returns the population variance of the array' do
          expect(StandardStats.varp(a)).to eq 6.5 / 6
        end
      end

      context 'given a low < 0' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { -1 }
        let(:high) { 5 }

        it 'raises a RangeError' do
          expect { StandardStats.varp(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given a high > array.size' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { 0 }
        let(:high) { 8 }

        it 'raises a RangeError' do
          expect { StandardStats.varp(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given low > high' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { 4 }
        let(:high) { 2 }

        it 'raises a RangeError' do
          expect { StandardStats.varp(a, low, high) }.to raise_error RangeError
        end
      end

      context 'given an array and a valid low and high' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { 0 }
        let(:high) { 5 }

        it 'returns the population variance of the sub-array' do
          expect(StandardStats.varp(a, low, high)).to eq 6.5 / 6
        end
      end
    end

    describe '.stddev' do
      context 'given an empty array' do
        let(:a) { [] }

        it 'returns Float::NAN' do
          expect(StandardStats.stddev(a)).to be_nan
        end
      end

      context 'given an array of equal values' do
        let(:a) { [2, 2, 2, 2, 2, 2] }

        it 'returns 0' do
          expect(StandardStats.stddev(a)).to eq 0
        end
      end

      context 'given an array of values' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4] }

        it 'returns the sample standard deviation' do
          expect(StandardStats.stddev(a)).to eq Math.sqrt(1.3)
        end
      end

      context 'given a low < 0' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { -1 }
        let(:high) { 5 }

        it 'raises a RangeError' do
          expect do
            StandardStats.stddev(a, low, high)
          end.to raise_error RangeError
        end
      end

      context 'given a high > array.size' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { 0 }
        let(:high) { 8 }

        it 'raises a RangeError' do
          expect do
            StandardStats.stddev(a, low, high)
          end.to raise_error RangeError
        end
      end

      context 'given low > high' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { 4 }
        let(:high) { 2 }

        it 'raises a RangeError' do
          expect do
            StandardStats.stddev(a, low, high)
          end.to raise_error RangeError
        end
      end

      context 'given an array and a valid low and high' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { 0 }
        let(:high) { 5 }

        it 'returns the population variance of the sub-array' do
          expect(StandardStats.stddev(a, low, high)).to eq Math.sqrt(1.3)
        end
      end
    end

    describe '.stddevp' do
      context 'given an empty array' do
        let(:a) { [] }

        it 'returns Float::NAN' do
          expect(StandardStats.stddevp(a)).to be_nan
        end
      end

      context 'given an array of equal values' do
        let(:a) { [2, 2, 2, 2, 2, 2] }

        it 'returns 0' do
          expect(StandardStats.stddevp(a)).to eq 0
        end
      end

      context 'given an array of values' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4] }

        it 'returns the sample standard deviation' do
          expect(StandardStats.stddevp(a)).to eq Math.sqrt(6.5 / 6)
        end
      end

      context 'given a low < 0' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { -1 }
        let(:high) { 5 }

        it 'raises a RangeError' do
          expect do
            StandardStats.stddevp(a, low, high)
          end.to raise_error RangeError
        end
      end

      context 'given a high > array.size' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { 0 }
        let(:high) { 8 }

        it 'raises a RangeError' do
          expect do
            StandardStats.stddevp(a, low, high)
          end.to raise_error RangeError
        end
      end

      context 'given low > high' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { 4 }
        let(:high) { 2 }

        it 'raises a RangeError' do
          expect do
            StandardStats.stddevp(a, low, high)
          end.to raise_error RangeError
        end
      end

      context 'given an array and a valid low and high' do
        let(:a) { [1, 1, 1.5, 2, 2.5, 4, 5] }
        let(:low) { 0 }
        let(:high) { 5 }

        it 'returns the population variance of the sub-array' do
          expect(StandardStats.stddevp(a, low, high)).to eq Math.sqrt(6.5 / 6)
        end
      end
    end
  end
end

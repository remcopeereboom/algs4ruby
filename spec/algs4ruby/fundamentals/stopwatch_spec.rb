require 'spec_helper'

module Algs4Ruby
  describe Stopwatch do
    describe '#initialize' do
      it 'creates a Stopwatch' do
        expect(Stopwatch.new).to be_a Stopwatch
      end
    end

    describe '#time_elapsed', slow_test: true do
      context 'called 3 seconds after creation' do
        it 'returns 3 or 4' do
          sw = Stopwatch.new

          sleep(3)

          expect(sw.elapsed_time.to_i).to eq(3).or eq 4
        end
      end
    end
  end
end

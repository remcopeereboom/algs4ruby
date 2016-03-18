require 'spec_helper'

module Algs4Ruby
  describe DoublingRatio do
    describe '.time_trial' do
      it 'returns a float' do
        expect(DoublingRatio.time_trial(5)).to be_a Float
      end
    end
  end
end

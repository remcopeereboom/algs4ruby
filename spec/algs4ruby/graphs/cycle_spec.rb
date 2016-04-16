require 'spec_helper'

module Algs4Ruby
  describe Cycle do
    describe '#has_cycle?' do
      context 'given a graph with a self-loop' do
        let(:graph) do
          g = Graph.new(1)
          g.add_edge(0, 0)
          g
        end
        let(:c) { Cycle.new(graph) }

        it 'returns true' do
          expect(c.has_cycle?).to be true
        end
      end

      context 'given a graph with a parallel edge' do
        let(:graph) do
          g = Graph.new(2)
          g.add_edge(0, 1)
          g.add_edge(0, 1)
          g
        end
        let(:c) { Cycle.new(graph) }

        it 'returns true' do
          expect(c.has_cycle?).to be true
        end
      end

      context 'given a disconnected graph' do
        let(:graph) { Graph.new(10) }
        let(:c) { Cycle.new(graph) }

        it 'returns false' do
          expect(c.has_cycle?).to be false
        end
      end

      context 'given a path' do
        let(:graph) { GraphGenerator.path(10) }
        let(:c) { Cycle.new(graph) }

        it 'returns false' do
          expect(c.has_cycle?).to be false
        end
      end

      context 'given a cyclic graph' do
        let(:graph) { GraphGenerator.cycle(10) }
        let(:c) { Cycle.new(graph) }

        it 'returns true' do
          expect(c.has_cycle?).to be true
        end
      end

      context 'given a complete graph with v > 2' do
        let(:graph) { GraphGenerator.complete(10) }
        let(:c) { Cycle.new(graph) }

        it 'returns true' do
          expect(c.has_cycle?).to be true
        end
      end
    end
  end
end

require 'spec_helper'

module Algs4Ruby
  describe DepthFirstPaths do
    describe '#marked?' do
      context 'called on an graph with no edges' do
        let(:v) { 10 }
        let(:e) { 0 }
        let(:source) { rand(v) }
        let(:graph) { GraphGenerator.simple(v, e) }
        let(:dfs) { DepthFirstPaths.new(graph, source) }

        it 'returns false for every v other than the source' do
          graph.v.times
                .reject { |w| w == source }
                .each { |w| expect(dfs.marked?(w)).to be false }
        end

        it 'returns true for the source' do
          expect(dfs.marked?(source)).to be true
        end
      end

      context 'called on a complete graph' do
        let(:v) { 10 }
        let(:source) { rand(v) }
        let(:graph) { GraphGenerator.complete(v) }
        let(:dfs) { DepthFirstPaths.new(graph, source) }

        it 'returns true for every v' do
          graph.v.times { |w| expect(dfs.marked?(w)).to be true }
        end
      end

      context 'called on a star graph' do
        let(:v) { 10 }
        let(:source) { rand(v) }
        let(:graph) { GraphGenerator.star(v) }
        let(:dfs) { DepthFirstPaths.new(graph, source) }

        it 'returns true for every v' do
          graph.v.times { |w| expect(dfs.marked?(w)).to be true }
        end
      end
    end
  end
end

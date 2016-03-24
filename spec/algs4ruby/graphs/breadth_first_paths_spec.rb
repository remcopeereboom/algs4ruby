require 'spec_helper'

module Algs4Ruby
  describe BreadthFirstPaths do
    describe '#marked?' do
      context 'called on an graph with no edges' do
        let(:v) { 10 }
        let(:e) { 0 }
        let(:source) { rand(v) }
        let(:graph) { GraphGenerator.simple(v, e) }
        let(:dfs) { BreadthFirstPaths.new(graph, source) }

        it 'returns false for every v other than the source' do
          graph.v.times
                .reject { |w| w == source }
                .each { |w| expect(dfs.marked?(w)).to be false }
        end

        it 'returns true for the source' do
          expect(dfs.marked?(source)).to be true
        end
      end

      context 'called on a complete graph with a single source' do
        let(:v) { 10 }
        let(:source) { rand(v) }
        let(:graph) { GraphGenerator.complete(v) }
        let(:dfs) { BreadthFirstPaths.new(graph, source) }

        it 'returns true for every v' do
          graph.v.times { |w| expect(dfs.marked?(w)).to be true }
        end

        it 'returns a proper distance' do
          graph.v.times do |w|
            if w == source
              expect(dfs.distance_to(w)).to eq 0
            else
              expect(dfs.distance_to(w)).to eq 1
            end
          end
        end
      end

      context 'called on a complete graph with v sources' do
        let(:v) { 10 }
        let(:sources) { Array 0...v }
        let(:graph) { GraphGenerator.complete(v) }
        let(:dfs) { BreadthFirstPaths.new(graph, sources) }

        it 'returns true for every v' do
          graph.v.times { |w| expect(dfs.marked?(w)).to be true }
        end

        it 'returns a distance of 0 for every v' do
          graph.v.times { |w| expect(dfs.distance_to(w)).to eq 0 }
        end
      end

      context 'called on a star graph' do
        let(:v) { 10 }
        let(:source) { rand(v) }
        let(:graph) { GraphGenerator.star(v) }
        let(:dfs) { BreadthFirstPaths.new(graph, source) }

        it 'returns true for every v' do
          graph.v.times { |w| expect(dfs.marked?(w)).to be true }
        end

        it 'returns a proper distance' do
          graph.v.times do |w|
            if w == source
              expect(dfs.distance_to(w)).to eq 0
            else
              expect(dfs.distance_to(w)).to be > 0
              expect(dfs.distance_to(w)).to be < v
            end
          end
        end
      end
    end
  end
end

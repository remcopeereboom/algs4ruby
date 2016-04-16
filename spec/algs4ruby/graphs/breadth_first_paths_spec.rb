require 'spec_helper'

module Algs4Ruby
  describe BreadthFirstPaths do
    describe '#marked?' do
      context 'called on an graph with no edges' do
        let(:v) { 10 }
        let(:e) { 0 }
        let(:source) { rand(v) }
        let(:graph) { GraphGenerator.simple(v, e) }
        let(:bfs) { BreadthFirstPaths.new(graph, source) }

        it 'returns false for every v other than the source' do
          graph.v.times
                .reject { |w| w == source }
                .each { |w| expect(bfs.marked?(w)).to be false }
        end

        it 'returns true for the source' do
          expect(bfs.marked?(source)).to be true
        end
      end

      context 'called on a complete graph with a single source' do
        let(:v) { 10 }
        let(:source) { rand(v) }
        let(:graph) { GraphGenerator.complete(v) }
        let(:bfs) { BreadthFirstPaths.new(graph, source) }

        it 'returns true for every v' do
          graph.v.times { |w| expect(bfs.marked?(w)).to be true }
        end

        it 'returns a proper distance' do
          graph.v.times do |w|
            if w == source
              expect(bfs.distance_to(w)).to eq 0
            else
              expect(bfs.distance_to(w)).to eq 1
            end
          end
        end
      end

      context 'called on a complete graph with v sources' do
        let(:v) { 10 }
        let(:sources) { Array 0...v }
        let(:graph) { GraphGenerator.complete(v) }
        let(:bfs) { BreadthFirstPaths.new(graph, sources) }

        it 'returns true for every v' do
          graph.v.times { |w| expect(bfs.marked?(w)).to be true }
        end
      end

      context 'called on a complete graph' do
        let(:v) { 10 }
        let(:source) { rand(v) }
        let(:graph) { GraphGenerator.complete(v) }
        let(:bfp) { BreadthFirstPaths.new(graph, source) }

        it 'returns true for every v' do
          graph.v.times { |w| expect(bfp.marked?(w)).to be true }
        end
      end

      context 'called on a star graph' do
        let(:v) { 10 }
        let(:source) { rand(v) }
        let(:graph) { GraphGenerator.star(v) }
        let(:bfp) { BreadthFirstPaths.new(graph, source) }

        it 'returns true for every v' do
          graph.v.times { |w| expect(bfp.marked?(w)).to be true }
        end
      end

      context 'called on the start of a path' do
        let(:v) { 10 }
        let(:source) { 0 }
        let(:graph) { GraphGenerator.path(v) }
        let(:bfp) { BreadthFirstPaths.new(graph, source) }

        it 'returns true for all v' do
          (0...v).each { |w| expect(bfp.marked?(w)).to be true }
        end
      end
    end

    describe '#distance_to?' do
      context 'called on an graph with no edges' do
        let(:v) { 10 }
        let(:e) { 0 }
        let(:source) { rand(v) }
        let(:graph) { GraphGenerator.simple(v, e) }
        let(:bfp) { BreadthFirstPaths.new(graph, source) }

        it 'returns 0 for the source' do
          expect(bfp.distance_to(source)).to be 0
        end

        it 'returns nil for every v other than the source' do
          graph.v.times
                .reject { |w| w == source }
                .each { |w| expect(bfp.distance_to(w)).to be nil }
        end
      end

      context 'called on a complete graph' do
        let(:v) { 10 }
        let(:source) { rand(v) }
        let(:graph) { GraphGenerator.complete(v) }
        let(:bfp) { BreadthFirstPaths.new(graph, source) }

        it 'returns 0 for the source' do
          expect(bfp.distance_to(source)).to be 0
        end

        it 'returns 1 for every v other than the source' do
          graph.v.times
                .reject { |w| w == source }
                .each { |w| expect(bfp.distance_to(w)).to be 1 }
        end
      end

      context 'called on a star graph' do
        let(:v) { 10 }
        let(:graph) { GraphGenerator.star(v) }
        let(:source) do
          (0...graph.v).max_by { |w| graph.adjacent(w).size }
        end
        let(:bfp) { BreadthFirstPaths.new(graph, source) }

        it 'returns 0 for the source' do
          expect(bfp.distance_to(source)).to be 0
        end

        it 'returns 1 for every v other than the source' do
          graph.v.times
                .reject { |w| w == source }
                .each { |w| expect(bfp.distance_to(w)).to be 1 }
        end
      end
    end
  end
end

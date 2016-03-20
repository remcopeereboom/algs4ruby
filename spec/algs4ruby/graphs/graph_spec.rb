require 'spec_helper'

module Algs4Ruby
  describe Graph do
    describe '#initialize' do
      context 'given no arguments' do
        let(:graph) { Graph.new }

        it 'returns a graph with no vertices' do
          expect(graph.v).to eq 0
        end

        it 'returns a graph with no edges' do
          expect(graph.e).to eq 0
        end
      end

      context 'given a number of vertices < 0' do
        it 'raises an ArgumentError' do
          expect { Graph.new(-1) }.to raise_error ArgumentError
        end
      end

      context 'given a number of vertices v >= 0' do
        let(:nr_of_vertices) { rand(0..1000) }
        let(:graph) { Graph.new(nr_of_vertices) }

        it 'returns a graph with v vertices' do
          expect(graph.v).to eq nr_of_vertices
        end

        it 'returns a graph with no edges' do
          expect(graph.e).to eq 0
        end
      end
    end

    describe '#add_edge' do
      let(:graph) { Graph.new(10) }

      context 'given a vertex id not in the graph' do
        let(:v) { rand(0...graph.v) }
        let(:w) { -1 }

        it 'raises an IndexError if passed as the first argument' do
          expect { graph.add_edge(v, w) }.to raise_error IndexError
        end

        it 'raises an IndexError if passed as the second argument' do
          expect { graph.add_edge(w, v) }.to raise_error IndexError
        end
      end

      context 'given two different valid vertex id\'s' do
        let(:v) { rand(0...(graph.v / 2)) }
        let(:w) { rand((graph.v / 2)...graph.v) }

        it 'increases the edge count for v by 1' do
          graph.add_edge(v, w)
          expect(graph.degree(v)).to eq 1
        end

        it 'increases the edge count for w by 1' do
          graph.add_edge(v, w)
          expect(graph.degree(w)).to eq 1
        end

        it 'adds an edge to v adjacent to w' do
          graph.add_edge(v, w)
          expect(graph.adjacent(v)).to include w
        end

        it 'adds an edge to w adjacent to v' do
          graph.add_edge(v, w)
          expect(graph.adjacent(w)).to include v
        end
      end

      context 'given two equal vertex id\'s' do
        let(:v) { rand(0...graph.v) }

        it 'increases the edge count for v by 2' do
          graph.add_edge(v, v)
          expect(graph.degree(v)).to eq 2
        end

        it 'adds an edge to v adjacent to v' do
          graph.add_edge(v, v)
          expect(graph.adjacent(v)).to include v
        end
      end
    end
  end
end

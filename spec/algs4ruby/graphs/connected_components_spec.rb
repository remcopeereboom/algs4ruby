require 'spec_helper'

module Algs4Ruby
  describe ConnectedComponents do
    describe '#count' do
      context 'given a completely unconnected graph' do
        let(:v) { 10 }
        let(:graph) { Graph.new(v) }
        let(:cc) { ConnectedComponents.new(graph) }

        it 'returns v' do
          expect(cc.count).to eq v
        end
      end

      context 'given a connected graph' do
        let(:v) { 10 }
        let(:graph) { GraphGenerator.complete(v) }
        let(:cc) { ConnectedComponents.new(graph) }

        it 'returns 1' do
          expect(cc.count).to eq 1
        end
      end

      context 'given a graph with v - 3 connected components ' do
        let(:v) { 10 }
        let(:graph) do
          g = Graph.new(v)
          g.add_edge(0, 1)
          g.add_edge(2, 3)
          g.add_edge(3, 4)
          g
        end
        let(:cc) { ConnectedComponents.new(graph) }

        it 'returns v - 3' do
          expect(cc.count).to eq v - 3
        end
      end
    end

    describe '#id' do
      context 'given an id not in the graph' do
        let(:v) { 10 }
        let(:graph) { GraphGenerator.complete(v) }
        let(:cc) { ConnectedComponents.new(graph) }
        let(:w) { [-1, v].sample }

        it 'returns nil' do
          expect(cc.id(v)).to be nil
        end
      end

      context 'given a complete graph' do
        let(:v) { 10 }
        let(:graph) { GraphGenerator.complete(v) }
        let(:cc) { ConnectedComponents.new(graph) }

        it 'returns the same id for all vertices in the graph' do
          v.times { |w| expect(cc.id(w)).to eq cc.id(0) }
        end
      end

      context 'given a completely unconnected graph' do
        let(:v) { 10 }
        let(:graph) { Graph.new(v) }
        let(:cc) { ConnectedComponents.new(graph) }

        it 'returns a the value of the vertex for all vertices in the graph' do
          v.times { |w| expect(cc.id(w)).to eq w }
        end
      end
    end

    describe '#size' do
      context 'given a vertex not in the graph' do
        let(:v) { 10 }
        let(:graph) { GraphGenerator.complete(v) }
        let(:cc) { ConnectedComponents.new(graph) }
        let(:w) { [-1, v].sample }

        it 'returns nil' do
          expect(cc.size(v)).to be nil
        end
      end

      context 'given a completely unconnected graph' do
        let(:v) { 10 }
        let(:graph) { Graph.new(v) }
        let(:cc) { ConnectedComponents.new(graph) }

        it 'returns 1 for all vertices in the graph' do
          v.times { |w| expect(cc.size(w)).to eq 1 }
        end
      end

      context 'given a complete graph' do
        let(:v) { 10 }
        let(:graph) { GraphGenerator.complete(v) }
        let(:cc) { ConnectedComponents.new(graph) }

        it 'returns v for all vertices in the graph' do
          v.times { |w| expect(cc.size(w)).to eq v }
        end
      end
    end

    describe '#connected?' do
      context 'given a vertex not in the graph' do
        let(:v) { 10 }
        let(:graph) { GraphGenerator.complete(v) }
        let(:cc) { ConnectedComponents.new(graph) }
        let(:u) { rand(v) }
        let(:w) { [-1, v].sample }

        it 'returns false' do
          expect(cc.connected?(u, w)).to be false
          expect(cc.connected?(w, u)).to be false
        end
      end

      context 'given the SAME vertices not in the graph' do
        let(:v) { 10 }
        let(:graph) { GraphGenerator.complete(v) }
        let(:cc) { ConnectedComponents.new(graph) }
        let(:w) { [-1, v].sample }

        it 'returns false' do
          expect(cc.connected?(w, w)).to be false
        end
      end

      context 'given the SAME vertices in a graph' do
        let(:v) { 10 }
        let(:graph) { Graph.new(v) }
        let(:cc) { ConnectedComponents.new(graph) }
        let(:w) { rand(v) }

        it 'returns true' do
          expect(cc.connected?(w, w)).to be true
        end
      end

      context 'given two vertices in the same connected component' do
        let(:v) { 10 }
        let(:graph) { GraphGenerator.complete(v) }
        let(:cc) { ConnectedComponents.new(graph) }
        let(:u) { rand(v) }
        let(:w) { rand(v) }

        it 'returns true' do
          expect(cc.connected?(u, w)).to be true
          expect(cc.connected?(w, u)).to be true
        end
      end

      context 'given two vertices not in the same connected component' do
        let(:v) { 10 }
        let(:graph) { Graph.new(v) }
        let(:cc) { ConnectedComponents.new(graph) }
        let(:w) { rand(0...(v/2)) }
        let(:u) { rand((v/2)...v) }

        it 'returns true' do
          expect(cc.connected?(u, w)).to be false
          expect(cc.connected?(w, u)).to be false
        end
      end
    end
  end
end

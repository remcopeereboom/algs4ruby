module Algs4Ruby
  RSpec.shared_examples 'a bipartite algorithm' do
    describe '#bipartite?' do
      context 'given a graph with one vertex' do
        let(:graph) { Graph.new(1) }
        let(:bp) { described_class.new(graph) }

        it 'returns true' do
          expect(bp.bipartite?).to be true
        end
      end

      context 'given a disconnected graph with two vertices' do
        let(:graph) { Graph.new(2) }
        let(:bp) { described_class.new(graph) }

        it 'returns true' do
          expect(bp.bipartite?).to be true
        end
      end

      context 'given a graph with two vertices and one edge between them' do
        let(:graph) do
          g = Graph.new(2)
          g.add_edge(0, 1)
          g
        end
        let(:bp) { described_class.new(graph) }

        it 'returns true' do
          expect(bp.bipartite?).to be true
        end
      end

      context 'given a star graph with n vertices' do
        let(:v) { rand(1..10) }
        let(:graph) { GraphGenerator.star(v) }
        let(:bp) { described_class.new(graph) }

        it 'returns true' do
          expect(bp.bipartite?).to be true
        end
      end

      context 'given a cycle graph with and odd number of vertices (v > 1)' do
        let(:v) { [3, 5, 7, 9].sample }
        let(:graph) { GraphGenerator.cycle(v) }
        let(:bp) { described_class.new(graph) }

        it 'returns false' do
          expect(bp.bipartite?).to be false
        end
      end

      context 'given a cycle graph with an even number of vertices' do
        let(:v) { [2, 4, 6, 8].sample }
        let(:graph) { GraphGenerator.cycle(v) }
        let(:bp) { described_class.new(graph) }

        it 'returns true' do
          expect(bp.bipartite?).to be true
        end
      end

      context 'given a complete graph with v > 2' do
        let(:v) { 10 }
        let(:graph) { GraphGenerator.complete(v) }
        let(:bp) { described_class.new(graph) }
        
        it 'returns false' do
          expect(bp.bipartite?).to be false
        end
      end

      context 'given a bipartite graph' do
        let(:v1) { 5 }
        let(:v2) { 5 }
        let(:graph) { GraphGenerator.complete_bipartite(v1, v2) }
        let(:bp) { described_class.new(graph) }

        it 'returns true' do
          expect(bp.bipartite?).to be true
        end
      end
    end

    describe '#color' do
      context 'given a non-bipartite graph' do
        let(:v) { [3, 5, 7, 9].sample }
        let(:graph) { GraphGenerator.cycle(v) }
        let(:bp) { described_class.new(graph) }

        it 'throws a NotBipartiteError' do
          expect { bp.color(rand(v)) }.to raise_error NotBipartiteError
        end
      end

      context 'given a vertex outside the graph' do
        let(:graph) { GraphGenerator.complete_bipartite(5, 5) }
        let(:bp) { described_class.new(graph) }

        it 'throws a RangeError' do
          expect { bp.color(-1) }.to raise_error RangeError
          expect { bp.color(10) }.to raise_error RangeError
        end
      end

      context 'given a vertex inside the range' do
        let(:v) { rand(10) }
        let(:graph) { GraphGenerator.complete_bipartite(5, 5) }
        let(:bp) { described_class.new(graph) }

        it 'returns a boolean for that vertex' do
          expect(bp.color(v)).to be(true).or be false
        end

        it 'returns the negation of color for all adjacent vertices' do
          graph.adjacent(v).each do |w|
            expect(bp.color(w)).to_not eq bp.color(v)
          end
        end
      end
    end
  end
end

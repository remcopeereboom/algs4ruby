require 'spec_helper'

module Algs4Ruby
  describe GraphGenerator do
    describe '.simple' do
      context 'given v < 0' do
        let(:v) { -1 }
        let(:e) { 10 }

        it 'raises an ArgumentError' do
          expect { GraphGenerator.simple(v, e) }.to raise_error ArgumentError
        end
      end

      context 'given e < 0' do
        let(:v) { 10 }
        let(:e) { -1 }

        it 'raises an ArgumentError' do
          expect { GraphGenerator.simple(v, e) }.to raise_error ArgumentError
        end
      end

      context 'given e > v * (v - 1) / 2' do
        let(:v) { 10 }
        let(:e) { v * (v - 1) / 2 + 1 }

        it 'raises an ArgumentError' do
          expect { GraphGenerator.simple(v, e) }.to raise_error ArgumentError
        end
      end

      context 'given v = 0 and e = 0' do
        let(:v) { 0 }
        let(:e) { 0 }
        let(:graph) { GraphGenerator.simple(v, e) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with 1 vertex' do
          expect(graph.v).to eq 0
        end

        it 'returns a graph with 0 edges' do
          expect(graph.e).to eq 0
        end
      end

      context 'given v > 0 and 0 <= e <= v * (v - 1) / 2' do
        let(:v) { rand(1..10) }
        let(:e) { rand(0..(v * (v - 1) / 2)) }
        let(:graph) { GraphGenerator.simple(v, e) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v vertices' do
          expect(graph.v).to eq v
        end

        it 'returns a graph with e edges' do
          expect(graph.e).to eq e
        end
      end
    end

    describe '.erdos_renyi' do
      context 'given v < 0' do
        let(:v) { -1 }
        let(:p) { rand(0.0..1.0) }

        it 'raises an ArgumentError' do
          expect { GraphGenerator.erdos_renyi(v, p) }.to raise_error ArgumentError
        end
      end

      context 'given p < 0' do
        let(:v) { 10 }
        let(:p) { -0.5 }

        it 'raises an ArgumentError' do
          expect { GraphGenerator.erdos_renyi(v, p) }.to raise_error ArgumentError
        end
      end

      context 'given p > 1' do
        let(:v) { 10 }
        let(:p) { 1.5 }

        it 'raises an ArgumentError' do
          expect { GraphGenerator.erdos_renyi(v, p) }.to raise_error ArgumentError
        end
      end

      context 'given a valid v and p = 0' do
        let(:v) { 10 }
        let(:p) { 0 }
        let(:graph) { GraphGenerator.erdos_renyi(v, p) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v vertices' do
          expect(graph.v).to eq v
        end

        it 'returns a graph with 0 edges' do
          expect(graph.e).to eq 0
        end
      end

      context 'given a valid v and p = 1' do
        let(:v) { 10 }
        let(:p) { 1 }
        let(:graph) { GraphGenerator.erdos_renyi(v, p) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v vertices' do
          expect(graph.v).to eq v
        end

        it 'returns a graph with (v**2 - v) / 2 edges' do
          expect(graph.e).to eq((v**2 - v) / 2)
        end
      end

      context 'given a valid v and a p in 0..1' do
        let(:v) { 10 }
        let(:p) { rand }
        let(:graph) { GraphGenerator.erdos_renyi(v, p) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v vertices' do
          expect(graph.v).to eq v
        end

        it 'returns a graph with between 0 and (v**2 - v) / 2 edges' do
          expect(graph.e).to be_between(0, (v**2 - v) / 2)
        end
      end
    end

    describe '.complete' do
      context 'given v < 0' do
        let(:v) { -10 }

        it 'raises an ArgumentError' do
          expect { GraphGenerator.complete(v) }.to raise_error ArgumentError
        end
      end

      context 'given v >= 0' do
        let(:v) { 10 }
        let(:graph) { GraphGenerator.complete(v) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v vertices' do
          expect(graph.v).to eq v
        end

        it 'returns a graph with (v**2 - v) / 2 edges' do
          expect(graph.e).to eq((v**2 - v) / 2)
        end
      end
    end

    describe '.bipartite' do
      context 'given v1 < 0' do
        let(:v1) { -1 }
        let(:v2) { 10 }
        let(:e) { 5 }

        it 'raises an ArgumentError' do
          expect do
            GraphGenerator.bipartite(v1, v2, e)
          end.to raise_error ArgumentError
        end
      end

      context 'given v2 < 0' do
        let(:v1) { 10 }
        let(:v2) { -1 }
        let(:e) { 5 }

        it 'raises an ArgumentError' do
          expect do
            GraphGenerator.bipartite(v1, v2, e)
          end.to raise_error ArgumentError
        end
      end

      context 'given e < 0' do
        let(:v1) { 10 }
        let(:v2) { 10 }
        let(:e) { -1 }

        it 'raises an ArgumentError' do
          expect do
            GraphGenerator.bipartite(v1, v2, e)
          end.to raise_error ArgumentError
        end
      end

      context 'given e > v1 * v2' do
        let(:v1) { 10 }
        let(:v2) { 10 }
        let(:e) { 101 }

        it 'raises an ArgumentError' do
          expect do
            GraphGenerator.bipartite(v1, v2, e)
          end.to raise_error ArgumentError
        end
      end

      context 'given v1 > 0, v2 > 0 and e = 0' do
        let(:v1) { 10 }
        let(:v2) { 5 }
        let(:e) { 0 }
        let(:graph) { GraphGenerator.bipartite(v1, v2, e) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v1 + v2 vertices' do
          expect(graph.v).to eq v1 + v2
        end

        it 'returns a graph with 0 edges' do
          expect(graph.e).to eq 0
        end
      end

      context 'given v1 > 0, v2 > 0 and e = v1 * v2' do
        let(:v1) { 10 }
        let(:v2) { 5 }
        let(:e) { v1 * v2 }
        let(:graph) { GraphGenerator.bipartite(v1, v2, e) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v1 + v2 vertices' do
          expect(graph.v).to eq v1 + v2
        end

        it 'returns a graph with v1 * v2 edges' do
          expect(graph.e).to eq v1 * v2
        end
      end

      context 'given v1 > 0, v2 > 0 and 0 <= e <= v1 * v2' do
        let(:v1) { rand(0..10) }
        let(:v2) { rand(0..10) }
        let(:e) { rand(0..(v1 * v2)) }
        let(:graph) { GraphGenerator.bipartite(v1, v2, e) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v1 + v2 vertices' do
          expect(graph.v).to eq v1 + v2
        end

        it 'returns a graph with e edges' do
          expect(graph.e).to eq e
        end
      end
    end

    describe '.complete_bipartite' do
      context 'given v1 < 0' do
        let(:v1) { -1 }
        let(:v2) { 10 }

        it 'raises an ArgumentError' do
          expect do
            GraphGenerator.complete_bipartite(v1, v2)
          end.to raise_error ArgumentError
        end
      end

      context 'given v2 < 0' do
        let(:v1) { 10 }
        let(:v2) { -1 }

        it 'raises an ArgumentError' do
          expect do
            GraphGenerator.complete_bipartite(v1, v2)
          end.to raise_error ArgumentError
        end
      end

      context 'given v1 >= 0 and v2 >= 0' do
        let(:v1) { rand(0..10) }
        let(:v2) { rand(0..10) }
        let(:graph) { GraphGenerator.complete_bipartite(v1, v2) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v1 + v2 vertices' do
          expect(graph.v).to eq v1 + v2
        end

        it 'returns a graph with v1 * v2 edges' do
          expect(graph.e).to eq v1 * v2
        end
      end
    end

    describe '.erdos_renyi_bipartite' do
      context 'given v1 < 0' do
        let(:v1) { -1 }
        let(:v2) { 10 }
        let(:p) { rand(0.0..1.0) }

        it 'raises an ArgumentError' do
          expect do
            GraphGenerator.erdos_renyi_bipartite(v1, v2, p)
          end.to raise_error ArgumentError
        end
      end

      context 'given v2 < 0' do
        let(:v1) { 10 }
        let(:v2) { -1 }
        let(:p) { rand(0.0..1.0) }

        it 'raises an ArgumentError' do
          expect do
            GraphGenerator.erdos_renyi_bipartite(v1, v2, p)
          end.to raise_error ArgumentError
        end
      end

      context 'given p < 0' do
        let(:v1) { 10 }
        let(:v2) { 10 }
        let(:p) { -0.5 }

        it 'raises an ArgumentError' do
          expect do
            GraphGenerator.erdos_renyi_bipartite(v1, v2, p)
          end.to raise_error ArgumentError
        end
      end

      context 'given p > 1.0' do
        let(:v1) { 10 }
        let(:v2) { 10 }
        let(:p) { 1.5 }

        it 'raises an ArgumentError' do
          expect do
            GraphGenerator.erdos_renyi_bipartite(v1, v2, p)
          end.to raise_error ArgumentError
        end
      end

      context 'given v1 = 0, v2 = 0' do
        let(:v1) { 0 }
        let(:v2) { 0 }
        let(:p) { rand(0.0..1.0) }
        let(:graph) { GraphGenerator.erdos_renyi_bipartite(v1, v2, p) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with 0 vertices' do
          expect(graph.v).to eq 0
        end

        it 'returns a graph with 0 edges' do
          expect(graph.e).to eq 0
        end
      end

      context 'given p = 0' do
        let(:v1) { rand(10) }
        let(:v2) { rand(10) }
        let(:p) { 0.0 }
        let(:graph) { GraphGenerator.erdos_renyi_bipartite(v1, v2, p) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v1 + v2 vertices' do
          expect(graph.v).to eq(v1 + v2)
        end

        it 'returns a graph with 0 edges' do
          expect(graph.e).to eq 0
        end
      end

      context 'given p = 1.0' do
        let(:v1) { rand(10) }
        let(:v2) { rand(10) }
        let(:p) { 1.0 }
        let(:graph) { GraphGenerator.erdos_renyi_bipartite(v1, v2, p) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v1 + v2 vertices' do
          expect(graph.v).to eq(v1 + v2)
        end

        it 'returns a graph with v1 * v2 / 2 edges' do
          expect(graph.e).to eq v1 * v2
        end
      end

    end

    describe '.path' do
      context 'given v < 0' do
        let(:v) { -1 }

        it 'raises an ArgumentError' do
          expect { GraphGenerator.path(v) }.to raise_error ArgumentError
        end
      end

      context 'given v = 0' do
        let(:v) { 0 }
        let(:graph) { GraphGenerator.path(v) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with zero vertices' do
          expect(graph.v).to eq 0
        end

        it 'returns a graph with 0 edges' do
          expect(graph.e).to eq 0
        end
      end

      context 'given v > 0' do
        let(:v) { rand(1..10) }
        let(:graph) { GraphGenerator.path(v) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v vertices' do
          expect(graph.v).to eq v
        end

        it 'returns a graph with v - 1 edges' do
          expect(graph.e).to eq(v - 1)
        end
      end
    end

    describe '.eulerian_path' do
      context 'given v < 1' do
        let(:v) { 0 }
        let(:e) { 2 }

        it 'raises an ArgumentError' do
          expect do
            GraphGenerator.eulerian_path(v, e)
          end.to raise_error ArgumentError
        end
      end

      context 'given e < 0' do
        let(:v) { 10 }
        let(:e) { -1 }

        it 'raises an ArgumentError' do
          expect do
            GraphGenerator.eulerian_path(v, e)
          end.to raise_error ArgumentError
        end
      end

      context 'given v > 0 and e >= 0' do
        let(:v) { rand(1..10) }
        let(:e) { rand(0..10) }
        let(:graph) { GraphGenerator.eulerian_path(v, e) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v vertices' do
          expect(graph.v).to eq v
        end

        it 'returns a graph with e edges' do
          expect(graph.e).to eq e
        end
      end
    end

    describe 'binary_tree' do
      context 'given v < 0' do
        let(:v) { -1 }

        it 'raises an ArgumentError' do
          expect { GraphGenerator.binary_tree(v) }.to raise_error ArgumentError
        end
      end

      context 'given v = 1' do
        let(:v) { 1 }
        let(:graph) { GraphGenerator.binary_tree(v) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with 1 vertex' do
          expect(graph.v).to eq 1
        end

        it 'returns a graph with 0 edges' do
          expect(graph.e).to eq 0
        end
      end

      context 'given v > 1' do
        let(:v) { rand(1..10) }
        let(:graph) { GraphGenerator.binary_tree(v) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v vertices' do
          expect(graph.v).to eq v
        end

        it 'returns a graph with v - 1 edges' do
          expect(graph.e).to eq(v - 1)
        end
      end
    end

    describe '.cycle' do
      context 'given v < 0' do
        let(:v) { -1 }

        it 'raises an ArgumentError' do
          expect { GraphGenerator.cycle(v) }.to raise_error ArgumentError
        end
      end

      context 'given v = 1' do
        let(:v) { 1 }
        let(:graph) { GraphGenerator.cycle(v) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with 1 vertex' do
          expect(graph.v).to eq 1
        end
        it 'returns a graph with 0 edges' do
          expect(graph.e).to eq 0
        end
      end

      context 'given v > 1' do
        let(:v) { rand(2..10) }
        let(:graph) { GraphGenerator.cycle(v) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v vertices' do
          expect(graph.v).to eq v
        end

        it 'returns a graph with v edges' do
          expect(graph.e).to eq v
        end
      end
    end

    describe '.eulerian_cycle' do
      context 'given v < 1' do
        let(:v) { 0 }
        let(:e) { 1 }

        it 'raises an ArgumentError' do
          expect do
            GraphGenerator.eulerian_cycle(v, e)
          end.to raise_error ArgumentError
        end
      end

      context 'given e < 1' do
        let(:v) { 1 }
        let(:e) { 0 }

        it 'raises an ArgumentError' do
          expect do
            GraphGenerator.eulerian_cycle(v, e)
          end.to raise_error ArgumentError
        end
      end

      context 'given v > 0 and e > 0' do
        let(:v) { rand(1..10) }
        let(:e) { rand(1..10) }
        let(:graph) { GraphGenerator.eulerian_cycle(v, e) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v vertices' do
          expect(graph.v).to eq v
        end

        it 'returns a graph with e edges' do
          expect(graph.e).to eq e
        end
      end
    end

    describe '.wheel' do
      context 'given v < 2' do
        let(:v) { rand(-10..1) }

        it 'raises an ArgumentError' do
          expect { GraphGenerator.wheel(v) }.to raise_error ArgumentError
        end
      end

      context 'given v = 2' do
        let(:v) { 2 }
        let(:graph) { GraphGenerator.wheel(v) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end
      end

      context 'given v > 2' do
        let(:v) { rand(2..10) }
        let(:graph) { GraphGenerator.wheel(v) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end
      end
    end

    describe '.star' do
      context 'given v < 1' do
        let(:v) { rand(-1..0) }

        it 'raises an ArgumentError' do
          expect { GraphGenerator.star(v) }.to raise_error ArgumentError
        end
      end

      context 'given v = 1' do
        let(:v) { 1 }
        let(:graph) { GraphGenerator.star(v) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with 1 vertex' do
          expect(graph.v).to eq 1
        end

        it 'returns a graph with no edges' do
          expect(graph.e).to eq 0
        end
      end

      context 'given v > 1' do
        let(:v) { rand(2..10) }
        let(:graph) { GraphGenerator.star(v) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v vertices' do
          expect(graph.v).to eq v
        end

        it 'returns a graph with v - 1 edges' do
          expect(graph.e).to eq(v - 1)
        end
      end
    end

    describe '.regular' do
      context 'given (v * k).odd? == true' do
        let(:v) { 21 } 
        let(:k) { 17 }

        it 'raises an ArgumentError' do
          expect { GraphGenerator.regular(v, k) }.to raise_error ArgumentError
        end
      end

      context 'given (v * k).even? == true' do
        let(:v) { 20 }
        let(:k) { 12 }
        let(:graph) { GraphGenerator.regular(v, k) }

        it 'returns an undirected graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v vertices' do
          expect(graph.v).to eq v
        end
      end
    end

    describe '.tree' do
      context 'given v < 0' do
        let(:v) { -1 }

        it 'raises an ArgumentError' do
          expect { GraphGenerator.tree(v) }.to raise_error ArgumentError
        end
      end

      context 'given v = 0' do
        let(:v) { 0 }
        let(:graph) { GraphGenerator.tree(v) }

        it 'returns an undirected Graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with 0 vertices' do
          expect(graph.v).to eq 0
        end

        it 'returns a graph with 0 edges' do
          expect(graph.e).to eq 0
        end
      end

      context 'given v = 1' do
        let(:v) { 1 }
        let(:graph) { GraphGenerator.tree(v) }

        it 'returns an undirected Graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with 1 vertex' do
          expect(graph.v).to eq 1
        end

        it 'returns a graph with 0 edges' do
          expect(graph.e).to eq 0
        end
      end

      context 'given v > 1' do
        let(:v) { rand 2..10 }
        let(:graph) { GraphGenerator.tree(v) }

        it 'returns an undirected Graph' do
          expect(graph).to be_a Graph
        end

        it 'returns a graph with v vertices' do
          expect(graph.v).to eq v
        end

        it 'returns a graph with v - 1 edges' do
          expect(graph.e).to eq(v - 1)
        end
      end
    end
  end
end

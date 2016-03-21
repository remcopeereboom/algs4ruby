module Algs4Ruby
  RSpec.shared_examples 'depth first search' do
    describe '#initialize' do
      context 'given a source vertex not in the graph' do
        let(:graph) { GraphGenerator.complete(10) }

        it 'raises an IndexError' do
          expect { described_class.new(graph, -1) }.to raise_error IndexError
          expect { described_class.new(graph, 10) }.to raise_error IndexError
        end
      end
    end

    describe '#marked?' do
      context 'given a vertex not in the graph' do
        let(:graph) { GraphGenerator.complete(10) }
        let(:dfs) { described_class.new(graph, rand(10)) }

        it 'returns false' do
          expect(dfs.marked?(-1)).to be false
          expect(dfs.marked?(graph.v)).to be false
        end
      end

      context 'called on a complete graph' do
        let(:graph) { GraphGenerator.complete(10) }
        let(:dfs) { described_class.new(graph, rand(10)) }

        it 'returns true for every vertex' do
          (0...graph.v).each do |w|
            expect(dfs.marked?(w)).to be true
          end
        end
      end
    end
  end
end

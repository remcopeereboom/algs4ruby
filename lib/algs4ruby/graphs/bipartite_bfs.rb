module Algs4Ruby
  # BipartiteBFS
  #
  # The {BipartiteBFS} class represents a data type for determining if an
  # undirected graph is bipartite or if it contains an odd-length cycle.
  #
  # The {#bipartite?} operation determines whether the graph is bipartite
  # or not. If it is, than the {#color} operation determines a bipartititon;
  # if it isn't, than the {#odd_cycle} operation returns an enumerable
  # containing the cycle.
  #
  # This implementation uses depth-first search. Because of that, the
  # initializer takes time proportional to v + e in the worst case, where v
  # is the number of vertices and e is the number of edges. Afterwards, all
  # other operations take constant time in the worst case.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  #
  # Testing client
  #
  # It takes four command-line arguments:
  #  v1 - the number of vertices in the left partition.
  #  v2 - the number of vertices in the right partition.
  #  e - the number of edges in the bipartite graph.
  #  f - the number of random edges to add.
  #
  # Creates a bipartite graph with v1 + v2 vertices and e edges. Then adds f
  # edges between a pair of randomly chosen vertices. If the resulting graph
  # is biparite, than it prints out the color to the console; if not, than
  # it prints out an odd-cycle in the graph.
  #
  # @!attribute odd_cycle [r]
  #   @return [Enumerable<Integer>] vertex identifiers that form an odd length
  #     cycle.
  class BipartiteBFS
    attr_reader :odd_cycle

    # Calculate if a given undirected graph is bipartite or if contains an odd
    # length cycle.
    # @param graph [Graph] an undirected graph.
    def initialize(graph)
      @is_bipartite = true
      @color = Array.new(graph.v, false)
      @marked = Array.new(graph.v, false)
      @edge_to = Array.new(graph.v, 0)

      graph.v.times do |w|
        return unless @is_bipartite
        bfs(graph, w) unless @marked[w]
      end
    end

    # Is the graph bipartite?
    # @return [Boolean] true if the graph is bipartite, false otherwise.
    def bipartite?
      @is_bipartite 
    end

    # What is the "color" of the given vertex. Here color determines if the
    # vertex lies in one partition or the other.
    # @param v [Integer] a vertex identifier.
    # @return [Boolean] true if it is in the "left" partition, false if it
    #   is in the "right" partition.
    # @raise [NotBipartiteError] if the graph is not bipartite.
    # @raise [RangeError] if v is not a vertex identifer of the graph.
    def color(v)
      if !bipartite?
        fail NotBipartiteError
      elsif v < 0 || @color.size <= v
        fail RangeError, "Vertex not in graph (#{v} for (0...#{@color.size})"
      end

      @color[v]
    end

    private

    # Recursive depth-first search.
    # @param graph [Graph] an undirected graph.
    # @param s [Integer] a vertex identifier.
    # @return [void]
    def bfs(graph, s)
      @marked[s] = true
      q = Queue.new
      q.enqueue(s)

      until q.empty?
        v = q.dequeue
        graph.adjacent(v).each do |w|
          if @marked[w]
            if @color[w] == @color[v]
              @is_bipartite = false
              set_cycle(v, w)
              return
            end
          else
            @marked[w] = true
            @edge_to[w] = v
            @color[w] = !@color[v]
            q.enqueue(w)
          end
        end
      end
    end

    # Sets @cycle to an odd-numbered cycle.
    # @param v [Integer] a vertex identifier.
    # @param w [Integer] a vertex identifier of a vertex adjacent to v,
    #   whose color is equal to v.
    # @return [void]
    def set_cycle(v, w)
      @odd_cycle = Queue.new
      stack = Stack.new

      while v != w
        stack.push(v)
        @odd_cycle.enqueue(w)
        v = @edge_to[v]
        w = @edge_to[w]
      end

      stack.push(v)
      @odd_cycle.enqueue(stack.pop) until stack.empty?
      @odd_cycle.enqueue(w)
    end
  end

  # Testing client
  #
  # It takes four command-line arguments:
  #  v1 - the number of vertices in the left partition.
  #  v2 - the number of vertices in the right partition.
  #  e - the number of edges in the bipartite graph.
  #  f - the number of random edges to add.
  #
  # Creates a bipartite graph with v1 + v2 vertices and e edges. Then adds f
  # edges between a pair of randomly chosen vertices. If the resulting graph
  # is biparite, than it prints out the color to the console; if not, than
  # it prints out an odd-cycle in the graph.
  if __FILE__ == $PROGRAM_NAME
    require_relative '../standard_io_libraries/standard_random'
    require_relative '../fundamentals/bag'
    require_relative '../fundamentals/stack'
    require_relative '../fundamentals/queue'
    require_relative '../graphs/graph'
    require_relative '../graphs/graph_generator'

    v1, v2, e, f = *ARGV.map(&:to_i)
    graph = GraphGenerator.bipartite(v1, v2, e)
    f.times do
      graph.add_edge(rand(v1 + v2), rand(v1 + v2))
    end
    bp = BipartiteBFS.new(graph)

    puts graph
    if bp.bipartite?
      puts "Graph is bipartite"
      graph.v.times { |w| puts "#{w}: #{bp.color(w)}" }
    else
      puts "Graph has an odd-length cycle"
      puts bp.odd_cycle.to_a
    end
  end
end

###############################################################################
# The code in this file is based on the java code in BipartiteX from
# alg4.jar library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# bipartite_bfs.rb is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# bipartite_bfs.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with bipartite_bfs.rb. If not, see http://www.gnu.org/licenses.
################################################################################

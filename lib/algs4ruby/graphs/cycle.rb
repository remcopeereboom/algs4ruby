require_relative '../fundamentals/stack'

module Algs4Ruby
  # Cycle
  #
  # The {Cycle} class represents a data type for determining whether an
  # undirected graph has a cycle. The {#has_cycle?} operation determines
  # whether the graph has a cycle, and if so, the {#cycle} attribute returns
  # one.
  #
  # This implementation uses depth-first search. The initializer takes time
  # proportional to v + e in the worst case, where v is the number of vertices
  # and e is the number of edges. Afterwards all operations take constant time.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # testing client:
  #   ruby cycle.rb graph
  #
  # The client takes an undirected graph as a command line argument and prints
  # out if the graph has a cycle. If it does, it prints a cycle.
  #
  # @!attribute cycle [r] Return a cycle from the graph (if there is one).
  #   @return [nil] if the graph is acyclic.
  #   @return [Enumerable<Integer>] an enumeration of the vertices of a cycle
  class Cycle
    attr_reader :cycle

    # Determines if the graph has a cycle. If so, find one.
    # @param graph [Graph] an undirected graph.
    def initialize(graph)
      return if has_self_loops?(graph)
      return if has_parallel_edges?(graph)

      @marked = Array.new(graph.v, false)
      @edge_to = Array.new(graph.v, 0)
      graph.v.times { |w| dfs(graph, -1, w) unless @marked[w] }
    end

    # Does the graph a cycle?
    # @return [Boolean] true if the graph has a cycle, false otherwise.
    def has_cycle?
      @cycle != nil
    end

    private

    # Does the graph have a self loop?
    # Sets @cycle if that's the case.
    # @param graph [Graph] an undirected graph.
    # @return [Boolean] true if the graph has a self loop, false otherwise.
    def has_self_loops?(graph)
      graph.v.times do |w|
        graph.adjacent(w).each do |u|
          if u == w
            @cycle = Stack.new
            @cycle.push w
            @cycle.push w

            return true
          end
        end
      end

      return false
    end

    # Does the graph have parallel edges?
    # Sets @cycle if that's the case.
    # @param graph [Graph] an undirected graph.
    # @return [Boolean] true if the graph has a parallel edge, false otherwise.
    def has_parallel_edges?(graph)
      @marked = Array.new(graph.v, false)
      graph.v.times do |w|
        graph.adjacent(w).each do |u|
          if @marked[u]
            @cycle = Stack.new
            @cycle.push w
            @cycle.push u
            @cycle.push w

            return true
          else
            @marked[u] = true
          end
        end

        graph.adjacent(w).each do |u|
          @marked[u] = false
        end
      end

      return false
    end

    # Depth-first serch for a cycle.
    # Sets @cycle if there is a cycle.
    # @param graph [Graph] an undirected graph.
    # @param u [Integer] vertex identifier.
    # @param v [Integer] vertex identifier.
    # @return [void]
    def dfs(graph, u, v)
      @marked[v] = true
      graph.adjacent(v).each do |w|
        return if @cycle

        if @marked[w]
          if w != u
            @cycle = Stack.new
            while v != w
              @cycle.push v
              v = @edge_to[v]
            end
            @cycle.push v
          end
        else
          @edge_to[w] = v
          dfs(graph, v, w)
        end
      end
    end
  end

  # Testing Client:
  #   ruby cycle.rb graph
  #
  # The client takes an undirected graph as a command line argument and prints
  # out if the graph has a cycle. If it does, it prints a cycle.
  if __FILE__ == $PROGRAM_NAME
    require_relative 'graph'
    require_relative '../fundamentals/bag'
    require_relative '../fundamentals/stack'

    f = File.open(ARGV.pop, 'r')
    graph = Graph.from(f)
    f.close

    c = Cycle.new(graph)

    if c.has_cycle?
      puts "Graph is cyclic"
      c.cycle.each { |w| print "#{w} " }
    else
      puts "Graph is acyclic"
    end
  end
end

###############################################################################
# The code in this file is based on the java code in Cycle from
# alg4.jar library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# cycle.rb is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# cycle.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with cycle.rb. If not, see http://www.gnu.org/licenses.
################################################################################

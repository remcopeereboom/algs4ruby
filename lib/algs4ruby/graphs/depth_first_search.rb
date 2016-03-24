module Algs4Ruby
  # DepthFirstSearch
  #
  # The DepthFirstSearch class represents a data type for determining which
  # vertices are connected to a given source vertex in an undirected graph.
  # For a version that find paths to the source vertex, see
  # {DepthFirstPaths}.
  #
  # This implementation uses depth-first search. The constructor takes time
  # proportional to v + e in the worst case, where v is the number of
  # vertices and e is the number of edges.
  # It uses extra space (not including the graph), proportional to v.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # Testing client:
  #   ruby depth_first_search.rb  graph source
  #
  # It takes two command-line arguments, a graph passed in from a file, and
  # a source vertex. It the prints out all the vertices connected to source.
  #
  # @!attribute count [r] The number of vertices to which there is a path from
  #   the source vertex.
  #   @return [Integer]
  class DepthFirstSearch
    attr_reader :count

    # Initializess a new DepthFirstSearch: computes the vertices that are
    # connected to the source vertex.
    # @param graph [Graph] an undirected graph.
    # @param source [Integer] index of the source vertex.
    # @raise [IndexError] if source is not a vertex in the graph.
    def initialize(graph, source)
      unless (0...graph.v).cover? source
        fail IndexError, "Invalid source vertex (#{source} for 0...#{graph.v})."
      end

      @count = 0
      @marked = Array.new(graph.v, false)
      dfs(graph, source)
    end

    # Is there a path between the source vertex and w?
    # @param w [Integer] an id of the vertex in the graph.
    # @return [Boolean] true if there is a path, false otherwise.
    def marked?(w)
      return false unless (0...@marked.size).cover? w
      @marked[w]
    end

    private

    # Depth first search from v - marks every unmarked vertex to which there is
    # a path from v.
    # @param v [Integer] a vertex in the graph.
    # @return [void]
    def dfs(graph, v)
      @count += 1
      @marked[v] = true

      graph.adjacent(v).each { |w| dfs(graph, w) unless marked?(w) }
    end
  end

  # Testing client
  #
  # It takes two command-line arguments, a graph passed in from a file, and
  # a source vertex. It the prints out all the vertices connected to source.
  if __FILE__ == $PROGRAM_NAME
    require_relative 'graph'
    require_relative '../fundamentals/bag'

    source = ARGV.pop.to_i
    f = File.open(ARGV.pop, 'r')
    graph = Graph.from(f)

    dfs = DepthFirstSearch.new(graph, source)
    graph.v.times { |x| puts "#{x} " if dfs.marked?(x) }

    puts
    if dfs.count != graph.v
      puts "NOT connected"
    else
      puts "connected"
    end
  end
end

###############################################################################
# The code in this file is based on the java code in DepthFirstSearch from
# alg4.jar library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# depth_first_search.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# depth_first_search.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with depth_first_search.rb. If not, see http://www.gnu.org/licenses.
################################################################################

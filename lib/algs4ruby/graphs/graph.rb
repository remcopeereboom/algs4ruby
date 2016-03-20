module Algs4Ruby
  # Graph
  #
  # The Graph class represents an undirected graph of vertices named 0...v.
  # It supports the following two primary operations: add an edge to the graph,
  # iterate over all of the vertices adjacent to a vertex. It also provides
  # methods for returning the number of vertices v and the number of edges e.
  # Parallel edges and self-loops are permitted.
  #
  # This implementation uses an adjacency-lists representation, which is a
  # vertex-indexed array of {Bag} objects.
  # All operations take constant time in the worst case, except for iterating
  # over the vertices adjacent to a given vertex, which takes time proportional
  # to the number of such vertices.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # Testing client:
  #   ruby graph.rb < in
  #   ruby graph
  #     nr_of_vertices
  #     nr_of_edges
  #     v1 w1
  #     v2 w2
  #     v3 w3
  #
  # Read in a graph from standard input and print it to standard output.
  #
  # @!attribute v [r] the number of vertices
  #   @return [Integer]
  # @!attribute e [r] the number of edges
  #   @return [Integer]
  class Graph
    # Initializes a graph from an input stream.
    # @param stream [IO] an input stream. The format is the number of vertices
    #   v, followed by the number of edges e, followed by pairs of vertices v w,
    #   separated by whitespace.
    # @return [Graph]
    # @raise [ArgumentError] if v < 0
    # @raise [ArgumentError] if e < 0
    # @raise [IndexError] if any of the edge vertices are invalid.
    def self.from(stream)
      v = stream.gets.to_i
      e = stream.gets.to_i

      if e < 0
        fail ArgumentError,
             "Number of edges must be non-negative (#{e} for 0+)."
      elsif v < 0
        fail ArgumentError,
             "Number of vertices must be non-negative (#{v} for 0+)."
      end

      e.times.with_object(Graph.new(v)) do |_, graph|
        v, w = stream.gets.split.map(&:to_i)
        graph.add_edge(v, w)
      end
    end

    attr_reader :v, :e

    # @overload #initialize()
    #  Initialize an empty Graph.
    # @overload #initialize(number_of_vertices)
    #  Initialized an empty Graph with v  vertices and 0 edges.
    #   @param v [Integer] the number of vertices in the graph.
    def initialize(v = 0)
      if v < 0
        fail ArgumentError,
             "Number of vertices must be non-negative (#{v} for 0+)."
      end

      @v = v
      @e = 0
      @adjacency_matrix = Array.new(v) { Bag.new }
    end

    # Adds the undirected edge v - w to this graph.
    # @param v [Integer] a vertex in the graph.
    # @param w [Integer] another vertex in the graph.
    # @return [void]
    def add_edge(v, w)
      validate_vertex(v)
      validate_vertex(w)

      @e += 1

      @adjacency_matrix[v].add(w)
      @adjacency_matrix[w].add(v)
    end

    # Returns the vertices adjacent to v.
    # @param v [Integer] the id of a vertex in the graph.
    # @return [Enumerable<Integer>] a collection of vertices adjacent to v.
    # @raise [IndexError] if v is not the id of a vertex in the graph.
    def adjacent(v)
      validate_vertex(v)

      @adjacency_matrix[v]
    end

    # Returns the degree of vertex v.
    # @param v [Integer] the id of a vertex in the graph.
    # @return [Integer] the degree of v.
    # @raise [IndexError] if v is not the id of a vertex in the graph.
    def degree(v)
      validate_vertex(v)

      @adjacency_matrix[v].size
    end

    # Returns a string representation of the graph.
    # @return [String]
    def to_s
      edges = v.times.each_with_object('') do |v, s|
        s << "#{v}: #{adjacent(v).sort.join(' ')}\n"
      end

      "#{v} vertices, #{e} edges\n#{edges}"
    end

    private

    # Fails an IndexError if vertex v is not a valid vertex id.
    # @param v [Integer] the id of a vertex.
    # @return [void]
    # @raise [IndexError] if v is not a valid vertex id.
    def validate_vertex(v)
      unless (0...@v).cover? v
        fail IndexError, "Invalid index (#{v} for #{0...@v})."
      end
    end
  end

  # Testing client
  #
  # Read in a graph from as a command line argument and print it to standard
  # output.
  if __FILE__ == $PROGRAM_NAME
    require_relative '../fundamentals/bag'

    puts Graph.from($stdin)
  end
end

###############################################################################
# The code in this file is based on the java code in Graph from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# graph.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# graph.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with graph.rb.  If not, see http://www.gnu.org/licenses.
################################################################################

require 'set'

module Algs4Ruby
  # GraphGenerator
  #
  # The GraphGenerator module provides methods for creating various kinds of
  # graphs, including Erdos-Renyi random graphs, random bipartite graphs.
  # random k-regular graphs, and random rooted trees.
  #
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # Testing client:
  #   ruby graph_generator.rb v e
  #
  # Takes an integer number of vertices and an integer number of edges as
  # command-line arguments. Then prints out various graphs to standard output.
  module GraphGenerator
    class << self
      # Returns a random simple graph with v vertices and e edges.
      # @param v [Integer] the number of vertices in the graph.
      # @param e [Integer] the number of edges in the graph.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] if v < 0
      # @raise [ArgumentError] if e < 0
      # @raise [ArgumentError] if e > v * (v - 1) / 2
      def simple(v, e)
        if e < 0
          fail ArgumentError, "Too few edges (#{e} for 0..#{v * (v - 1) / 2})."
        elsif e > v * (v - 1) / 2
          fail ArgumentError, "Too many edges (#{e} for 0..#{v * (v - 1) / 2})."
        end

        graph = Graph.new(v)

        edges = Set.new
        while graph.e < e
          a = StandardRandom.uniform(v)
          b = StandardRandom.uniform(v)
          next if a == b

          edge = Edge.new(a, b)
          unless edges.include?(edge)
            edges.add(edge)
            graph.add_edge(a, b)
          end
        end

        graph
      end
      
      # Returns a random simple graph with v vertices, with an edge between any
      # two vertices with probability p. This is sometimes referred to as the
      # Erdos-Renyi random graph model.
      # @param v [Integer] the number of vertices in the graph.
      # @param p [Float] the per-vertex chance of generating an edge to another
      #   vertex.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] if v < 0
      # @raise [ArgumentError] if p < 0 or p > 1.0
      def erdos_renyi(v, p)
        unless (0.0..1.0).cover? p
          fail ArgumentError, "Not a valid probability (#{p} for 0.0..1.0)."
        end

        graph = Graph.new(v)
        (0...v).each do |a|
          ((a + 1)...v).each do |b|
            graph.add_edge(a, b) if StandardRandom.bernoulli(p)
          end
        end

        graph
      end

      # Returns a complete graph with v verticces.
      # @param v [Integer] the number of vertices in the graph.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] if v < 0
      def complete(v)
        erdos_renyi(v, 1.0)
      end

      # Returns a random simple bipartite graph with v1 and v2 vertices,
      # and with e edges connecting them.
      # @param v1 [Integer] the number of edges in one partition.
      # @param v2 [Integer] the number of edges in the other partition.
      # @param e [Integer] the number of edges connecting the partitions.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] if v1 or v2 < 0
      # @raise [ArgumentError] if 0 < e < v1 * v2
      def bipartite(v1, v2, e)
        if e < 0
          fail ArgumentError, "Too few edges (#{e} for 0..#{v1 * v2})."
        elsif e > v1 * v2
          fail ArgumentError, "Too many edges (#{e} for 0..#{v1 * v2})."
        end

        graph = Graph.new(v1 + v2)
        vertices = Array 0...(v1 + v2)
        StandardRandom.shuffle!(vertices)

        edges = Set.new
        while graph.e < e
          a = StandardRandom.uniform(v1)
          b = StandardRandom.uniform(v2)

          edge = Edge.new(vertices[a], vertices[b])
          unless edges.include? edge
            edges.add(edge)
            graph.add_edge(vertices[a], vertices[b])
          end
        end

        graph
      end

      # Returns a complete bipartite graph with v1 vertices in one partition
      # and v2 vertices in the other partition.
      # @param v1 [Integer] the number of edges in one partition.
      # @param v2 [Integer] the number of edges in the other partition.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] if v1 or v2 < 0
      def complete_bipartite(v1, v2)
        bipartite(v1, v2, v1 * v2)
      end

      # Returns a simple bipartite graph with v1 and v2 vertices containing
      # each possible edge with a propabiltiy p
      # @param v1 [Integer] the number of edges in one partition.
      # @param v2 [Integer] the number of edges in the other partition.
      # @param p [Float] the probability of a given edge being in the graph.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] if v1 or v2 < 0
      # @raise [ArgumentError] if 0 < e < v1 * v2
      def erdos_renyi_bipartite(v1, v2, p)
        if v1 < 0
          fail ArgumentError, "v1 is not a valid partition (#{v1} for 0+)."
        elsif v2 < 0
          fail ArgumentError, "v2 is not a valid partition (#{v2} for 0+)."
        elsif !(0.0..1.0).cover? p
          fail ArgumentError, "Not a probability (#{p} for 0.0..1.0)."
        end

        vertices = Array 0...(v1 + v2)
        StandardRandom.shuffle!(vertices)

        graph = Graph.new(v1 + v2)
        (0...v1).each do |i|
          (0...v2).each do |j|
            if StandardRandom.bernoulli(p)
              graph.add_edge(vertices[i], vertices[v1 + j]) 
            end
          end
        end

        graph
      end

      # Returns a path graph with v vertices.
      # @note the path is random so will not necessarily go 1->2->3...
      # @param v [Integer] the number of vertices.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] of v < 0.
      def path(v)
        graph = Graph.new(v)

        vertices = Array 0...v
        StandardRandom.shuffle!(vertices)

        vertices.each_cons(2) { |v, w| graph.add_edge(v, w) }

        graph
      end

      # Returns an Eulerian path graph with v vertices and e edges.
      # @param v [Integer] the number of vertices.
      # @param e [Integer] the number of edges.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] of v < 1.
      # @raise [ArgumentError] of e < 0.
      def eulerian_path(v, e)
        if e < 0
          fail ArgumentError,
               "Cannot have a negative number of edges (#{e} for 0+)."
        elsif v < 1
          fail ArgumentError,
               "A Eulerian path must have a least one vertex (#{v} for 1+)."
        end

        graph = Graph.new(v)

        vertices = Array.new(e + 1) { StandardRandom.uniform(v) }
        vertices.each_cons(2) { |v, w| graph.add_edge(v, w) }

        graph
      end

      # Returns an Eulerian cycle graph with v vertices and e edges.
      # @param v [Integer] the number of vertices.
      # @param e [Integer] the number of edges.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] of v < 1.
      # @raise [ArgumentError] of e < 1.
      def eulerian_cycle(v, e)
        if e < 1
          fail ArgumentError,
               "A Eulerian cycle must have a least one edge (#{e} for 1+)."
        elsif v < 1
          fail ArgumentError,
               "A Eulerian cycle must have a least one vertex (#{v} for 1+)."
        end

        graph = Graph.new(v)

        vertices = Array.new(e) { StandardRandom.uniform(v) }
        vertices.each_cons(2) { |v, w| graph.add_edge(v, w) }
        graph.add_edge(vertices.first, vertices.last)

        graph
      end

      # Returns a complete binary tree graph with v vertices.
      # @param v [Integer] the number of vertices.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] of v < 0.
      def binary_tree(v)
        graph = Graph.new(v)

        vertices = Array 0...v
        StandardRandom.shuffle!(vertices)

        (1...v).each { |i| graph.add_edge(vertices[i], vertices[(i - 1) / 2]) }

        graph
      end

      # Returns a cycle graph.
      # @param v [Integer] the number of vertices.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] of v < 0.
      def cycle(v)
        graph = Graph.new(v)

        vertices = Array 0...v
        StandardRandom.shuffle!(vertices)

        vertices.each_cons(2) { |v, w| graph.add_edge(v, w) }
        graph.add_edge(vertices.last, vertices.first) if v > 1

        graph
      end

      # Returns a wheel graph with v vertices. A wheel graph has a vertex which
      # is connected to every other vertex of a cycle.
      # @param v [Integer] the number of vertices.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] of v < 2.
      def wheel(v)
        fail ArgumentError, "Not enough vertices (#{v} for 2+)." if v < 2

        graph = Graph.new(v)

        vertices = Array 0...v
        StandardRandom.shuffle!(vertices)

        # Simple cycle on v - 1 vertices.
        vertices[0...(v-1)].each_cons(2) { |v, w| graph.add_edge(v, w) }
        graph.add_edge(vertices.first, vertices.last)

        # Connect vertex 0 to every other vertex.
        (1...v).each { |i| graph.add_edge(vertices[0], vertices[i]) }

        graph
      end

      # Returns a star graph with v vertices.
      # @param v [Integer] the number of vertices.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] of v < 1.
      def star(v)
        fail ArgumentError, "Not enough vertices (#{v} for 1+)." if v < 1

        graph = Graph.new(v)

        vertices = Array 0...v
        StandardRandom.shuffle!(vertices)

        # Connect vertex 0 to every other vertex.
        (1...v).each { |i| graph.add_edge(vertices[0], vertices[i]) }

        graph
      end

      # Returns a uniformly random k-regular graph with v vertices (not
      # necessarily simple). The graph is simple with probability
      # ~ e**(-k**2 / 4), which is tiny for k >= 14.
      # @param v [Integer] the number of vertices.
      # @param k [Integer] the degree of each vertex.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] if v < 0
      # @raise [ArgumentError] if k < 0
      # @raise [ArgumentError] if v * k % 2 != 0
      def regular(v, k)
        # This implementation uses the pairing algorithm:
        # 1. Begin with a set of n vertices.
        # 2. Create a new set of nk points, distributing them across n buckets,
        #    such that each bucket contains k points.
        # 3. Take each point and pair it randomly with another one, until
        #    0.5 * n * k pairs are obtained (i.e., a perfect matching).
        #    Collapse the points, so that each bucket (and thus the points it
        #    contains) maps onto a single vertex of the original graph.
        # 4. Retain all edges between points as the edges of the corresponding
        #    vertices
        if k < 0
          fail ArgumentError "Graph degree must be non-negative (#{k} for 0+)."
        elsif (v * k).odd?
          fail ArgumentError, "v * k must be even (#{v * k} for 2, 4, 6, ..)."
        end

        graph = Graph.new(v)

        # Create k copies of each vertex.
        vertices = Array.new(v * k)
        (0...v).each do |i|
          (0...k).each { |j| vertices[i + v * j] = i }
        end

        StandardRandom.shuffle!(vertices)
        (0...(v * k / 2)).each do |i|
          graph.add_edge(vertices[2 * i], vertices[2 * i + 1])
        end

        graph
      end

      # Returns a uniformly random tree with v vertices.
      # This algorithm uses a Prufer sequence and takes time proportional to
      # v log v.
      # @param v [Integer] the number of vertices.
      # @return [Graph] an undirected graph.
      # @raise [ArgumentError] if v < 0.
      def tree(v)
        graph = Graph.new(v)
        return graph if v < 2

        # Cayley's theorem: there are v**(v - 2) labeled trees on v vertices.
        # Prufer sequence: sequence of v - 2 values in the range 0...v.
        # Prufer's proof of Cayley's theorem: Prufer sequences are in one-to-one
        #   with labeled trees on v vertices.
        prufer_seq = Array.new(v - 2) { StandardRandom.uniform(v) }

          # Degree of vertex v = 1 + number of times it appears in Prufer sequence.
        degrees = Array.new(v, 1)
        prufer_seq.each { |i| degrees[i] += 1 }

        # Add all vertices of degree 1 to a priority queue.
        pq = MinPQ.new((0...v).select { |i| 1 == degrees[i] })

        (0...(v - 2)).each do |i|
          a = pq.delete_min
          b = prufer_seq[i]

          graph.add_edge(a, b)
          degrees[a] -= 1
          degrees[b] -= 1

          pq.insert(b) if degrees[b] == 1
        end

        graph.add_edge(pq.delete_min, pq.delete_min)

        graph
      end
    end

    # Private helper class describing an undirected edge.
    # @api private
    #
    # @!attribute v [r] the end-point of the edge with the lowest vertex id.
    #   @return [Integer] the id of the vertex end-point.
    # @!attribute w [r] the end-point of the edge with the highest vertex id.
    #   @return [Integer] the id of the vertex end-point.
    class Edge
      include Comparable
      attr_reader :v, :w

      # Initializes a new undirected Edge.
      # @param v [Integer] an index of a vertex.
      # @param w [Integer] an index of a vertex.
      def initialize(v, w)
        if v < w
          @v = v
          @w = w
        else
          @v = w
          @w = v
        end
      end

      # Compares one edge to another.
      # Imposes a total order on edges. Edges with a smaller smallest end-point
      # are considered less than edgges with a larger smallest end-point. In
      # case of ties, the order is imposed by the largest end-point, where again
      # a smaller end-point indicates a lower order for the edge.
      def <=>(other)
        @v == other.v ? @w <=> other.w : @v <=> other.v
      end
    end
  end

  # Testing client
  #
  # Read lines from ARGF and put them in the bag.
  # Then print out the size of the bag.
  # Then print the items in the bag.
  if __FILE__ == $PROGRAM_NAME
    require_relative '../standard_io_libraries/standard_random'
    require_relative '../fundamentals/bag'
  #  require_relative '../sorting/priority_queue'
    require_relative 'graph'

    v, e = ARGV.map(&:to_i)
    v1 = v / 2
    v2 = v - v1 # Deal with odd-even rounding errors!

    puts 'Complete graph'
    puts GraphGenerator.complete(v)
    puts

    puts 'Simple graph'
    puts GraphGenerator.simple(v, e)
    puts

    puts 'Erdos-Renyi graph'
    p = e / (v * (v - 1) / 2.0)
    puts GraphGenerator.erdos_renyi(v, p)
    puts

    puts 'Complete bipartite graph'
    puts GraphGenerator.complete_bipartite(v1, v2)
    puts

    puts 'Bipartite graph'
    puts GraphGenerator.bipartite(v1, v2, e)
    puts

    puts 'Erdos-Reny bipartite graph'
    puts GraphGenerator.erdos_renyi_bipartite(v1, v2, q)
    puts

    puts 'Path graph'
    puts GraphGenerator.path(v)
    puts

    puts 'Cycle graph'
    puts GraphGenerator.cycle(v)
    puts

    puts 'Binary tree graph'
    puts GraphGenerator.binary_tree(v)
    puts

    puts 'Tree graph'
    puts GraphGenerator.tree(v)
    puts

    puts '4-regular graph'
    puts GraphGenerator.regular(v, 4)
    puts

    puts 'Star graph'
    puts GraphGenerator.star(v)
    puts

    puts 'Wheel graph'
    puts GraphGenerator.wheel(v)
    puts
  end
end

###############################################################################
# The code in this file is based on the java code in GraphGenerator from
# alg4.jar library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# graph_generator.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# graph_generator.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with graph_generator.rb.  If not, see http://www.gnu.org/licenses.
################################################################################

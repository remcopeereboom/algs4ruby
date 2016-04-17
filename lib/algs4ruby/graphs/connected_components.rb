module Algs4Ruby
  # ConnectedComponents
  # The ConnectedComponents class represents a data type for determining the
  # connected components in an undirected graph.
  #
  # The {#id} operation determines in which connected component a given vertex
  # lies. The {#connected?} operation determines whether two vertices lie in
  # the same connected component. The {#count} attribute returns the total
  # number of connected components. The {#size} attribute returns the number
  # of vertices in the connected component containing the given vertex.
  #
  # The component identifier of a connected component is one of the vertices
  # in the connected component: two vertices have the same component identifier
  # if and only if they are in the same connected component.
  #
  # This implementation uses depth-first-search.
  # The initializer takes time proportional to v + e in the worst case, where
  # v is the number of vertices and e the number of edges in the graph.
  # Afterwards, all other operations take only constant time.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # testing client:
  #   ruby connected_components.rb graph
  #
  # The client takes a graph as a command line argument and prints the
  # connected components and its matching vertices.
  class ConnectedComponents
    attr_reader :count

    # Computes the connected components. 
    # @param graph [Graph] an undirected graph.
    def initialize(graph)
      @count = 0
      @marked = Array.new(graph.v, false)
      @id = Array.new(graph.v, 0)
      @size = Array.new(graph.v, 0)

      graph.v.times do |w|
        next if @marked[w]
        dfs(graph, w)
        @count += 1
      end
    end

    # Returns the component identifier of the component containing v.
    # @param v [Integer] a vertex identifier.
    # @return [nil] if v is not in the graph.
    # @return [Integer] the component identifier of v if v is in the graph.
    def id(v)
      return nil if v < 0 || @id.size <= v
      @id[v]
    end

    # Returns the size of the component containing v.
    # @param v [Integer] a vertex identifier.
    # @return [nil] if v is not in the graph.
    # @return [Integer] the size of the component containing v if v
    #   is in the graph.
    def size(v)
      return nil if v < 0 || @size.size <= v
      @size[@id[v]]
    end

    # Are v and w connected?
    # @param v [Integer] a vertex identifier.
    # @param w [Integer] a vertex identifier.
    # @return [false] if either v or w are not in the graph. Note: this will
    #   return false even if v and w are the same!
    # @return [Boolean] true if v and w are in the same connected component,
    #   false otherwise.
    def connected?(v, w)
      return false if v < 0 || @id.size <= v
      return false if w < 0 || @id.size <= w

      @id[v] == @id[w]
    end

    private

    # Recursive depth-first-search.
    # @param graph [Graph] an undirected graph.
    # @param v [Integer] a vertex identifier.
    # @return [void]
    def dfs(graph, v)
      @marked[v] = true
      @id[v] = @count
      @size[@count] += 1

      graph.adjacent(v).each { |w| dfs(graph, w) unless @marked[w] }
    end
  end

  # Testing client
  #
  # It takes two command-line arguments, a graph passed in from a file, and
  # a source vertex. It then prints out all the vertices connected to source.
  if __FILE__ == $PROGRAM_NAME
    require_relative 'graph'
    require_relative '../fundamentals/bag'
    require_relative '../fundamentals/queue'

    f = File.open(ARGV.pop, 'r')
    graph = Graph.from(f)

    cc = ConnectedComponents.new(graph)

    components = Array.new(cc.count) { Queue.new }
    graph.v.times { |w| components[cc.id(w)].enqueue(w) }

    puts "#{cc.count} components"
    components.map do |vertices|
      puts vertices.to_a.join(' ')
    end
  end
end

###############################################################################
# The code in this file is based on the java code in CC from
# alg4.jar library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# connected_components.rb is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# connected_components.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with connected_components.rb. If not, see http://www.gnu.org/licenses.
################################################################################

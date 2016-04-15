module Algs4Ruby
  # DepthFirstPaths
  #
  # The DepthFirstPaths class represents a data type for finding paths from a
  # source vertex to every other vertex in an undirected graph.
  #
  # This implementation uses depth-first search. The initializer takes time
  # proportional to v + e, where v is the number of vertices in the graph and
  # e the number of edges. It uses extra space (not including the graph, to
  # which no reference is maintained) proportional to v.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # testing client:
  #   ruby depth_first_paths.rb graph source
  #
  # It takes two command-line arguments, a graph passed in from a file, and
  # a source vertex. It then prints out all the vertices connected to source.
  class DepthFirstPaths
    # Initializes a new DepthFirstPaths.
    # @note initialization is NOT a cheap operation!
    # @param graph [Graph] an undirected graph.
    # @param source [Integer] a vertex id.
    def initialize(graph, source)
      @source = source
      @marked = Array.new(graph.v, false)
      @edge_to = Array.new(graph.v)

      dfs(graph, @source)
    end

    # Is there a path from the source to vertex v?
    # @param v [Integer] a vertex id.
    # @return [Boolean] true if there is such a path, false otherwise.
    def marked?(v)
      @marked[v]
    end
    alias has_path_to? marked?

    # Returns an enumerator of the path between the source vertex and vertex v,
    # or nil if there is no such path.
    # @param v [Integer] a vertex id.
    # @return [Enumerator<Integer>] the path if there is a path.
    # @return [nil] if there is no path.
    def path_to(v)
      return nil unless has_path_to?(v)

      path = Stack.new
      x = v
      while x != @source
        path.push(x)
        x = @edge_to[x]
      end
      path.push(@source)

      path
    end

    private

    # Depth first search from v.
    # @param graph [Graph] an undirected graph.
    # @param v [Integer] a vertex id.
    # @return [void]
    def dfs(graph, v)
      @marked[v] = true
      graph.adjacent(v).each do |w|
        unless marked?(w)
          @edge_to[w] = v
          dfs(graph, w)
        end
      end
    end
  end

  # Testing client
  #
  # It takes two command-line arguments, a graph passed in from a file, and
  # a source vertex. It then prints out all the vertices connected to source.
  if __FILE__ == $PROGRAM_NAME
    require_relative 'graph'
    require_relative '../fundamentals/bag'
    require_relative '../fundamentals/stack'

    source = ARGV.pop.to_i
    f = File.open(ARGV.pop, 'r')
    graph = Graph.from(f)

    dfs = DepthFirstPaths.new(graph, source)
    graph.v.times do |v|
      if dfs.has_path_to?(v)
        print "#{source} to #{v}:"
        dfs.path_to(v).each { |w| print(w == source ? w : "-#{w}") }
        puts
      else
        puts "#{source} not connected to #{v}."
      end
    end
  end
end

###############################################################################
# The code in this file is based on the java code in DepthFirstPaths from
# alg4.jar library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# depth_first_paths.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# depth_first_paths.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with depth_first_paths.rb. If not, see http://www.gnu.org/licenses.
################################################################################

module Algs4Ruby
  # Testing client
  #   ruby average.rb in1 in2 in3 out
  #
  # Takes a list of n files from the command-line and concatenates the
  # first n - 1 and writes them to the nth file.
  if __FILE__ == $PROGRAM_NAME
    File.open(ARGV.pop, 'w') do |f|
      ARGF.readlines.each { |l| f.write(l) }
    end
  end
end

###############################################################################
# The code in this file is based on the java code in Cat from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# cat.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# cat.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with cat.rb. If not, see http://www.gnu.org/licenses.
################################################################################

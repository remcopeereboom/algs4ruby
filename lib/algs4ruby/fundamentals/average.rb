module Algorithms
  # Testing client
  #   ruby average.rb < file1 file2 file3
  #   ruby average.rb 23.4 123 12.4
  #
  # Read lines from ARGF and converts each line to a floating point number.
  # Computes the average of those numbers and prints it to standard out.
  if __FILE__ == $PROGRAM_NAME
    count = 0
    sum = 0.0
    ARGF.readlines.each do |l|
      sum += l.to_f
      count += 1
    end

    puts "Average is #{sum / count}."
  end
en

###############################################################################
# The code in this file is based on the java code in Average from alg4.jar
# library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# average.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# average.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with average.rb. If not, see http://www.gnu.org/licenses.
################################################################################

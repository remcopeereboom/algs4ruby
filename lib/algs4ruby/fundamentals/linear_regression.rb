module Algs4Ruby
  # LinearRegression
  #
  # The LinearRegression class performs a linear regression on a set of n
  # data points. That is, it fits a straight line y = ax + b, where y is the
  # response variable and x is the predictor variable, that minimizes the sum
  # of the squared residuals of the linear regression model.
  #
  # It also computes associated statistics, including the coefficient of
  # determination (r**2) and the standard deviations of the estimates for the
  # slope and for the y-intercept.
  #
  # The code is based on the Java library with the same name found at
  # http://algs4.cs.princeton.edu
  #
  # @!attribute intercept [r] The intercept b of the best-fit line y = ax +b.
  #   @return [Numeric] the intercept.
  # @!attribute slope [r] The slope a of the best-fit line y = ax +b.
  #   @return [Numeric] the slope.
  # @!attribute r2 [r] The coeffcient of determination r**2.
  #   @return [Numeric] a number between 0 and 1.
  class LinearRegression
    attr_reader :intercept
    attr_reader :slope
    attr_reader :r2

    # Calculate a linear regression for the data set xs-ys.
    # @param xs [Array<Numeric>] a set of x-coordinates.
    # @param ys [Array<Numeric>] a corresponding set of y-coordinates.
    # @raise [ArgumentError] if xs.length != ys.length
    def initialize(xs, ys)
      if xs.length != ys.length
        fail ArgumentError, 'Arrays must be of equal length.'
      end

      n = xs.length

      xbar = xs.inject(0.0, :+) / n
      ybar = ys.inject(0.0, :+) / n

      xxbar = 0.0
      yybar = 0.0
      xybar = 0.0

      (0...n).each do |i|
        xxbar += (xs[i] - xbar) * (xs[i] - xbar)
        yybar += (ys[i] - ybar) * (ys[i] - ybar)
        xybar += (xs[i] - xbar) * (ys[i] - ybar)
      end

      @slope = xybar / xxbar
      @intercept = ybar - slope * xbar

      # RSS - Residual sum of squares.
      # SSR - Regression sum of squares.
      rss = 0.0
      ssr = 0.0
      (0...n).each do |i|
        fit = @slope * xs[i] + @intercept
        rss += (fit - ys[i]) * (fit - ys[i])
        ssr += (fit - ybar) * (fit - ybar)
      end

      degrees_of_freedom = n - 2
      @r2 = ssr / yybar
      @svar = (degrees_of_freedom == 0 ? Float::NAN : ssr / degrees_of_freedom)
      @svar1 = @svar / xxbar
      @svar0 = @svar / n + xbar * xbar * @svar1
    end

    # Returns the standard error of the estimate for the slope.
    # @return [Float::NAN] if insufficient degrees of freedom.
    # @return [Numeric] the error in the slope.
    def slope_std_err
      Math.sqrt(@svar1)
    end

    # Returns the standard error of the estimate for the intercept.
    # @return [Float::NAN] if insufficient degrees of freedom.
    # @return [Numeric] the error in the intercept.
    def intercept_std_err
      Math.sqrt(@svar0)
    end

    # Returns the expected response y, given the value of the predictor
    # variablle x.
    # @param x [Numeric] the value of the predictor variable.
    # @return [Numeric] the expected respons to the given predictor variable.
    def predict(x)
      @slope * x + @intercept
    end

    # Returns a string representation of the linear regression, including
    # the best-fit line and the coefficient of determination.
    # @return [String]
    def to_s
      "#{slope} * x + #{intercept} (R^2: #{r2})"
    end
  end
end

###############################################################################
# The code in this file is based on the java code in LinearRegression from
# alg4.jar library. That library can be found at http://algs4.cs.princeton.edu
# You can find more information on the alg4.jar library on that website.
#
#
# Copyright of the algs4.jar libary belongs to Robert Sedgewick and
# Kevin Wayne. Attribution of the algorithms can be found at the princeton
# website as well.
#
# linear_regression.rb is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# linear_regression.rb is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with linear_regression.rb. If not, see http://www.gnu.org/licenses.
################################################################################

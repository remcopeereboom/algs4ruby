$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'algs4ruby'

RSpec.configure do |c|
  c.filter_run_excluding slow_test: true
end

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'algs4ruby/version'

Gem::Specification.new do |spec|
  spec.name        = 'algs4ruby'
  spec.version     = Algs4ruby::VERSION
  spec.authors     = ['Remco Peereboom']
  spec.email       = ['rpeere@yandex.com']

  spec.summary     = 'Algs4 algorithms, clients and data structures in ruby'
  spec.homepage    = 'https://github.com/remcopeereboom/algs4ruby'
  spec.license     = 'GPLv3'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    fail 'RubyGems ~> 2.0 is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0")
                                        .reject do |f|
                                          f.match(%r{^(test|spec|features)/})
                                        end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'flog'
  spec.add_development_dependency 'flay'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'pry'
end

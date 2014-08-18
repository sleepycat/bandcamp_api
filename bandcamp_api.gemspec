# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bandcamp/version'

Gem::Specification.new do |gem|
  gem.name          = "bandcamp_api"
  gem.version       = Bandcamp::VERSION
  gem.authors       = ["Mike Williamson"]
  gem.email         = ["blessedbyvirtuosity@gmail.com"]
  gem.description   = "A helper library for accessing the Bandcamp.com api"
  gem.summary       = "A library for communicating with the Bandcamp.com api and wrapping the various types of data to make it easier to work with."
  #gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency "rspec", '~> 3.0', '>= 3.0.0'
  gem.add_development_dependency 'rspec-collection_matchers', '~> 1.0', '>= 1.0.0'
  gem.add_runtime_dependency "multi_json", '~> 1.10', '>= 1.10.1'
end

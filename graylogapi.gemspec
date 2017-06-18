# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'graylogapi/version'

Gem::Specification.new do |spec|
  spec.name          = 'graylogapi'
  spec.version       = GraylogAPI::VERSION
  spec.authors       = ['Andrey Aleksandrov']
  spec.email         = ['postgred@gmail.com']

  spec.summary       = 'Ruby gem for working with Graylog API'
  spec.description   = 'Allows you to work with graylog api from ruby'
  spec.homepage      = 'https://github.com/postgred/graylogapi'

  spec.files         = ['README.md', 'graylogapi.gemspec', 'LICENSE'] +
                       Dir['lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
end

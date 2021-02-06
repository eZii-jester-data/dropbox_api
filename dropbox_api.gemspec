# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dropbox_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'dropbox_api'
  spec.version       = DropboxApi::VERSION
  spec.authors       = ['Jesús Burgos']
  spec.email         = ['jburmac@gmail.com']

  spec.summary       = 'Library for communicating with Dropbox API v2'
  spec.homepage      = 'https://github.com/Jesus/dropbox_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.7'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'

  spec.add_dependency 'faraday', '~> 1.0'
  spec.add_dependency 'oauth2', '~> 1.1'
end

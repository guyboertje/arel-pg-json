# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arel/pg_json/build_info'

Gem::Specification.new do |spec|
  spec.name          = "arel-pg-json"
  spec.homepage      = ''
  spec.require_paths = ['lib']

  Arel::PgJson::BuildInfo.new.add_to_gemspec(spec)

  spec.add_runtime_dependency 'arel'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency "minitest", "~> 5.7.0"
end

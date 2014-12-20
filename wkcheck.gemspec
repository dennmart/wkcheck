# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wkcheck/version'

Gem::Specification.new do |s|
  s.name          = "wkcheck"
  s.version       = WKCheck::VERSION
  s.date          = "2014-04-14"
  s.summary       = "Check your WaniKani stats from the command line"
  s.description   = "Check your pending lessons and reviews of your WaniKani account (http://www.wanikani.com/) from the command line"
  s.authors       = ["Dennis Martinez"]
  s.email         = "dennis@dennmart.com"
  s.homepage      = "http://github.com/dennmart/wkcheck"
  s.license       = "MIT"
  s.executables   = ["wkcheck"]
  s.require_paths = ["lib", "lib/wkcheck"]
  s.files         = %w[
    README.md
    bin/wkcheck
    wkcheck.gemspec
    lib/wkcheck.rb
    lib/wkcheck/stats.rb
    lib/wkcheck/critical_items.rb
    lib/wkcheck/version.rb
  ]

  s.required_ruby_version = '>= 1.9.2'

  s.add_runtime_dependency "wanikani", "~> 1.0"
  s.add_runtime_dependency "slop", "~> 3.5"
  s.add_runtime_dependency "rainbow", "~> 2.0"

  s.add_development_dependency "aruba", "~> 0.6"
  s.add_development_dependency "mocha", "~> 1.1"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "minitest", "~> 5.5"
end

Gem::Specification.new do |s|
  s.name          = "wkcheck"
  s.version       = "0.0.2"
  s.date          = "2013-05-12"
  s.summary       = "Check your WaniKani stats from the command line"
  s.description   = "Check your pending lessons and reviews of your WaniKani account (http://www.wanikani.com/) from the command line"
  s.authors       = ["Dennis Martinez"]
  s.email         = "dennis@dennmart.com"
  s.homepage      = "http://github.com/dennmart/wkcheck"
  s.executables   = ["wkcheck"]
  s.require_paths = ["lib"]
  s.files         = %w[
    README.md
    bin/wkcheck
    wkcheck.gemspec
    lib/wkcheck.rb
  ]

  s.required_ruby_version = '>= 1.9.2'

  s.add_runtime_dependency "wanikani", "~> 0.0.4"
  s.add_runtime_dependency "slop", "~> 3.4.4"
  s.add_runtime_dependency "rainbow", "~> 1.1.4"

  s.add_development_dependency "aruba", "~> 0.5.2"
  s.add_development_dependency "mocha", "~> 0.13.3"
  s.add_development_dependency "rake", "~> 10.0.4"
end

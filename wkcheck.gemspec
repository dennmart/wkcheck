Gem::Specification.new do |s|
  s.name          = "wkcheck"
  s.version       = "0.0.6"
  s.date          = "2013-10-24"
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
  ]

  s.required_ruby_version = '>= 1.9.2'

  s.add_runtime_dependency "wanikani", "~> 0.0.6"
  s.add_runtime_dependency "slop", "~> 3.4.4"
  s.add_runtime_dependency "rainbow", "~> 1.1.4"

  s.add_development_dependency "aruba", "~> 0.5.2"
  s.add_development_dependency "mocha", "~> 0.13.3"
  s.add_development_dependency "rake", "~> 10.0.4"
end

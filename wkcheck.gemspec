Gem::Specification.new do |s|
  s.name        = "wkstats"
  s.version     = "0.0.1"
  s.date        = "2013-05-10"
  s.summary     = "Check your WaniKani stats from the command line"
  s.description = "Check your pending lessons and reviews of your WaniKani account (http://www.wanikani.com/) from the command line"
  s.authors     = ["Dennis Martinez"]
  s.email       = "dennis@dennmart.com"
  s.homepage    = "http://github.com/dennmart/wkstats"
  s.executables = ["wkcheck"]
  s.files       = %w[
    README.md
    bin/wkcheck
    wkcheck.gemspec
  ]

  s.required_ruby_version = '>= 1.9.2'

  s.add_runtime_dependency "wanikani", "~> 0.0.3"
  s.add_runtime_dependency "slop", "~> 3.4.4"

  s.add_development_dependency "aruba", "~> 0.5.2"
end

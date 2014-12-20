require "bundler/gem_tasks"
require 'cucumber'
require 'cucumber/rake/task'
require 'rake/testtask'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
end

namespace :test do
  desc "Run all unit tests and Cucumber scenarios"
  task :all do
    Rake::Task["features"].execute
    Rake::Task["test"].execute
  end
end

task(default: :test)

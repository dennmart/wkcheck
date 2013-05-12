require 'cucumber/rake/task'
require 'rake/testtask'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

Rake::TestTask.new do |t|
  t.test_files = Dir.glob('test/*_test.rb')
end

desc "Run all unit tests and Cucumber scenarios"
task :test_all do
  Rake::Task["features"].execute
  Rake::Task["test"].execute
end

task(default: :test)

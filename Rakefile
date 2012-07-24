# encoding: utf-8

require 'bundler'
Bundler::GemHelper.install_tasks

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "crumby"
  gem.homepage = "http://github.com/phatworx/crumby"
  gem.license = "MIT"
  gem.summary = %Q{Easy breadcrumb for rails}
  gem.description = %Q{Easy breadcrumb for rails}
  gem.email = "dev@cc-web.eu"
  gem.authors = ["Christoph Chilian"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  #  gem.add_runtime_dependency 'jabber4r', '> 0.1'
  #  gem.add_development_dependency 'rspec', '> 1.2.3'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc "Run tests with SimpleCov"
RSpec::Core::RakeTask.new('coverage') do |t|
  ENV['COVERAGE'] = "true"
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new

#!/usr/bin/env rake

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'Run specs'
RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = '--tag ~@integration'
end

task :default => :spec

desc 'Run integration specs'
RSpec::Core::RakeTask.new('spec:integration') do |task|
  task.rspec_opts = '--tag @integration'
end

require 'yard'
require 'yard/rake/yardoc_task'

YARD::Rake::YardocTask.new

desc 'Generate Documentation'
task :doc => :yard

#!/usr/bin/env rake

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'Run specs'
RSpec::Core::RakeTask.new(:spec)

task :default => :spec

require 'yard'
require 'yard/rake/yardoc_task'

YARD::Rake::YardocTask.new

desc 'Generate Documentation'
task :doc => :yard

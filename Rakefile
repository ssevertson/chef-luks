#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'kitchen/rake_tasks'
require 'foodcritic'
 
desc 'Default: run Chefspec, Foodcritic, and Test Kitchen'
task :default => :test
 
task 'test' => %w(spec kitchen:all foodcritic)

RSpec::Core::RakeTask.new do |t|
    t.pattern = './spec/**/*_spec.rb'
end

# Exclude tag FC017 since we're supporting why run
FoodCritic::Rake::LintTask.new do |t|
  t.options = { :tags => ['~FC017'] }
end

Kitchen::RakeTasks.new

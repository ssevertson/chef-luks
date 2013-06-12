#!/usr/bin/env rake
require 'kitchen/rake_tasks'
require 'foodcritic'
 
desc 'Default: run Foodcritic and Test Kitchen'
task :default => :test
 
task 'test' => %w(kitchen:all foodcritic)

# Exclude tag FC017 since we're supporting why run
FoodCritic::Rake::LintTask.new do |t|
  t.options = { :tags => ['~FC017'] }
end

Kitchen::RakeTasks.new

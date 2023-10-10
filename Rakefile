# frozen_string_literal: true

require_relative 'config/application'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'reek/rake/task'

Rails.application.load_tasks

RSpec::Core::RakeTask.new(:rspec) do |task|
  task.pattern = 'spec/**/*_spec.rb'
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['**/*.rb']
end

Reek::Rake::Task.new do |task|
  task.patterns = ['**/*.rb']
end

task default: [:rspec]

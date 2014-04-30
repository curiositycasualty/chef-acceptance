require "rspec/core/rake_task"

chef_test_dir = ENV['CHEF_TEST_DIR'] = File.dirname(__FILE__)

task :default => [:spec]
RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
  task.verbose = false
end

desc 'Bootstrap browser environment and start pry'
task :console do
  $LOAD_PATH << './spec'
  
  require 'spec_helper'
  Capybara.visit Capybara.app_host

  require 'pry'
  binding.pry
end

desc 'Install required Gems into the vendor/bundle directory'
task :bundle do
  system('bundle install --path vendor/bundle --binstubs')
end
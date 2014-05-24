require "rspec/core/rake_task"
require 'sauce'

chef_test_dir = ENV['CHEF_TEST_DIR'] = File.dirname(__FILE__)

# task :default => [:spec]
RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
  task.verbose = true
 # task.rspec_opts = %w[-f JUnit -o results.xml]
end

desc 'Bootstrap browser environment and start pry'
task :console do
  ['./spec'].each { |d| 
    $LOAD_PATH << d
  }
  
  require 'spec_helper'
  Capybara.visit Capybara.app_host

  require 'capybara/DSL'
  include Capybara::DSL
  require 'pry'
  binding.pry
end

desc 'Install required Gems into the vendor/bundle directory'
task :bundle do
  system("bundle install --path vendor/bundle --binstubs")
end

desc 'Clean bundled gems dir then install required Gems into the vendor/bundle directory'
task :rebundle do
  system("rm -rf vendor/bundle bin Gemfile.lock ")
  Rake::Task['bundle'].execute
end

task :berks_install do
  cookbooks_path = File.join(chef_test_dir, "vendor/cookbooks")
  system("rm -rf #{cookbooks_path} && #{chef_test_dir}/bin/berks vendor #{cookbooks_path}")
end
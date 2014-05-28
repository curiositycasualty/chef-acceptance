require "rspec/core/rake_task"
require 'sauce'

chef_test_dir = ENV['CHEF_TEST_DIR'] = File.dirname(__FILE__)

# task :default => [:spec]
RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
  task.verbose = false
 # task.rspec_opts = %w[-f JUnit -o results.xml]
end

desc 'Run tests on local workstation'
task :local do
  system "bundle exec rake spec"
end

desc 'Run single threaded tests on Sauce'
task :on_sauce do
  system "RUN_ON_SAUCE=true bundle exec rake spec"
end

desc 'Run tests concurrently on Sauce'
task :parallel_on_sauce do
  system "RUN_ON_SAUCE=true bundle exec rake sauce:spec"
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
  system("rm -rf vendor/bundle Gemfile.lock .bundle bin ")
  Rake::Task['bundle'].execute
end

task :berks_install do
  cookbooks_path = File.join(chef_test_dir, "vendor/cookbooks")
  system("rm -rf #{cookbooks_path} && #{chef_test_dir}/bin/berks vendor #{cookbooks_path}")
end
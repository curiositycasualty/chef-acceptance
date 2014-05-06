require "rspec/core/rake_task"

chef_test_dir = ENV['CHEF_TEST_DIR'] = File.dirname(__FILE__)
work_dir = ENV['CHEF_TEST_WORK'] = "#{chef_test_dir}/work"

task :default => [:spec]
RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
  task.verbose = false
end

desc 'Bootstrap browser environment and start pry'
task :console do
  ['./spec', './lib'].each { |d| 
    $LOAD_PATH << d
  }
  
  require 'spec_helper'
  Capybara.visit Capybara.app_host

  require 'pry'
  binding.pry
end

desc 'Install required Gems into the vendor/bundle directory'
task :bundle do
  system("bundle install --path work/vendor/bundle --binstubs")
end

desc 'Clean bundled gems dir then install required Gems into the vendor/bundle directory'
task :rebundle do
  system("rm -rf work/vendor/bundle")
  Rake::Task['bundle'].execute
end

task :berks_install do
  cookbooks_path = File.join(chef_test_dir, "work/vendor/cookbooks")
  system("#{chef_test_dir}/bin/berks vendor #{cookbooks_path}")
end
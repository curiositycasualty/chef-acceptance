require "rspec/core/rake_task"

RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
  task.verbose = false
end


task :console do
  $LOAD_PATH << './spec'
  
  require 'spec_helper'
  Capybara.visit Capybara.app_host

  require 'pry'
  binding.pry
end
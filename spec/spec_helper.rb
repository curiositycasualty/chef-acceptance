require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'site_prism'
require 'yaml'
require 'factory_girl'
require 'fileutils'
require 'util'
require 'chef_manage_app'

# make test config file configurable - env var
test_config = YAML::load_file(File.join(ENV['CHEF_TEST_DIR'], 'test-config.yml'))

RSpec.configure do |c|
  c.include(ChefManageApp)
  c.include(FactoryGirl::Syntax::Methods)
  
  #need to add a focus rake task or rspec arg
  # c.filter_run :focus => true
end

# set base url
if ENV['app_host']
  Capybara.app_host = ENV['app_host']
else
  Capybara.app_host = test_config['app_host']
end

ENV['search_host'] = test_config['search_host'] unless ENV['search_host']

# set implicit webdriver wait time
Capybara.default_wait_time = test_config['wait_time']
# configure site prism to use implicit wait
SitePrism.configure do |config|
  config.use_implicit_waits = true
end

# find factories in default locations
I18n.enforce_available_locales = false
FactoryGirl.find_definitions

if ENV["RUN_ON_SAUCE"]
  require 'sauce_helper'
else
  # this will eventually truly configurable
  Capybara.default_driver = test_config['driver'].to_sym
  Capybara.register_driver test_config['driver'].to_sym do |app|
    Capybara::Selenium::Driver.new(app, :browser => test_config['browser'].to_sym)
  end
  Capybara.current_session.driver.browser.manage.window.maximize
end

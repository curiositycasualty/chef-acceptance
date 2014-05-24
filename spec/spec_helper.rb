require 'sauce_helper'
require 'capybara'
require 'sauce'
require 'sauce/capybara'
require 'capybara/rspec'

require 'selenium-webdriver'
require 'site_prism'

#require 'sauce/parallel'

require 'yaml'
require 'factory_girl'
require 'fileutils'
require 'util'

# require 'sections/navigation'


# RSpec.configure do |c|
#   c.include Header
# end

# make test config file configurable - env var
test_config = YAML::load_file(File.join(ENV['CHEF_TEST_DIR'], 'test-config.yml'))

# set implicit webdriver wait time
Capybara.default_wait_time = test_config['wait_time']
# configure site prism to use implicit wait

SitePrism.configure do |config|
  config.use_implicit_waits = true
end

# set base url
ENV['app_host'] = Capybara.app_host = test_config['app_host']
ENV['search_host'] = test_config['search_host']

# work together driver + browser
# #Capybara.default_driver = test_config['driver'].to_sym
# Capybara.register_driver test_config['driver'].to_sym do |app|
#   Capybara::Selenium::Driver.new(app, :browser => test_config['browser'].to_sym)
# end




# # maximize the window
#Capybara.current_session.driver.browser.manage.window.maximize

Capybara.default_driver = :sauce
Capybara.javascript_driver = :sauce

# find factories in default locations
I18n.enforce_available_locales = false
FactoryGirl.find_definitions

require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'site_prism'
require 'yaml'
require 'factory_girl'
require 'fileutils'
require 'util'

# make test config file configurable - env var
test_config = YAML::load_file(File.join(ENV['CHEF_TEST_DIR'], 'test-config.yml'))

RSpec.configure do |c|
  #c.filter_run :focus => true
end

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
Capybara.default_driver = test_config['driver'].to_sym
Capybara.register_driver test_config['driver'].to_sym do |app|
  Capybara::Selenium::Driver.new(app, :browser => test_config['browser'].to_sym)
end

# maximize the window
Capybara.current_session.driver.browser.manage.window.maximize

# find factories in default locations
FactoryGirl.find_definitions

# setup dir for generated pem files
FileUtils.mkdir_p "#{ENV['CHEF_TEST_DIR']}/work/pems"

require 'pages/sign_up'
module ChefManageApp
  def sign_up_page
    Page::SignUp.new 
  end
end


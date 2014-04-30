require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'site_prism'
require 'yaml'

# make test config file configurable - env var
test_config = YAML::load_file(File.join(File.dirname(__FILE__), '../test-config.yml'))

Capybara.default_wait_time = test_config['wait_time']

Capybara.app_host = test_config['app_host']

# work together driver + browser
Capybara.default_driver = test_config['driver'].to_sym
Capybara.register_driver test_config['driver'].to_sym do |app|
 Capybara::Selenium::Driver.new(app, :browser => test_config['browser'].to_sym)
end
Capybara.current_session.driver.browser.manage.window.maximize

SitePrism.configure do |config|
  config.use_implicit_waits = true
end

require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'site_prism'
require 'yaml'
require 'capybara/poltergeist'
require 'manage_app'

# make test config file configurable
test_config = YAML::load_file(File.join(__dir__, '../test-config.yml'))

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

# #Capybara.register_driver :poltergeist do |app|
# #  Capybara::Poltergeist::Driver.new(app)
# #end
 
# Capybara.default_driver = :poltergeist
# Capybara.register_driver :poltergeist do |app|
#   Capybara::Poltergeist::Driver.new(app, {:phantomjs_options => ['--ignore-ssl-errors=yes'], :debug => true})
# end

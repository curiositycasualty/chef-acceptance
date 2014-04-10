require 'capybara/rspec'
require 'pages/login_page'

# todo: this will be configurable via config file
app_host = 'https://manage.opscode.piab'
driver = :selenium
browser = :firefox

Capybara.app_host = app_host

# work together driver + browser
Capybara.default_driver = driver
Capybara.register_driver driver do |app|
  Capybara::Selenium::Driver.new(app, :browser => browser)
end
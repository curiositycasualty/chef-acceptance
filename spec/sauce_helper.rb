require 'sauce'
require 'capybara'
require 'sauce/capybara'

Capybara.default_driver = :sauce
Capybara.javascript_driver = :sauce

Sauce.config do |c|
  c[:browsers] = YAML::load_file(File.join(ENV['CHEF_TEST_DIR'], 'browsers.yml'))
end


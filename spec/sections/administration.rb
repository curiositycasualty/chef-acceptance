require 'spec_helper'
require 'capybara/dsl'
  
module Administration
  include Capybara::DSL
  
  def go_to_users
    click_link 'Users'
  end
end

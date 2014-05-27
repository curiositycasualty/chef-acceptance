require 'spec_helper'
require 'capybara/dsl'
  
module Policy
  include Capybara::DSL
  
  def go_to_cookbooks
  end

  def go_to_roles
    click_link 'Roles'
  end

  def go_to_data_bags
    click_link 'Data Bags'
  end

  def go_to_environments
    click_link 'Environments'
    sleep 1
  end

  def go_to_clients
    click_link 'Clients'
  end
end

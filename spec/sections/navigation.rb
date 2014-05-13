require 'spec_helper'
require 'capybara/dsl'

module Navigation
  include Capybara::DSL
  
  class Header 
    class << self
      def open_feedback_modal
        find('div.usernav-section.report-bug').click
      end

      def click_chef_logo
        click_link '#logo'
      end

      def sign_out
        find('div.usernav-section.user').find('div.dropdown').find('a.dropdown-toggle').click
        find('li.logout > a').click
      end

      def go_to_administration
        click_link 'Administration'
      end

      def go_to_policy
        click_link 'Policy'
      end

      def go_to_reports
        clink_link 'Reports'
      end

      def go_to_nodes
        click_link 'Nodes'
      end

      def signed_in_as
        find('span.user-dropdown span.dropdown-toggle-label').text
      end

      def select_organization(name)
        find('div.usernav-section.organization').find('div.dropdown').find('a.dropdown-toggle').click
        find(:xpath, "//a[contains(text(),'#{name}')]").click
      end

      def current_organization
        find('span.organization-dropdown span.dropdown-toggle-label').text
      end

      def manage_organizations
        find('div.usernav-section.organization').find('div.dropdown').find('a.dropdown-toggle').click
        find(:xpath, "//a[contains(text(),'Manage Organizations')]").click
      end
    end
  end

  class Policy
    class << self
      def go_to_cookbooks
      end

      def go_to_roles
        click_link 'Roles'
      end

      def go_to_data_bags
      end

      def go_to_environments
      end

      def go_to_clients
        click_link 'Clients'
      end
    end
  end

  class Administration
    class << self
      def go_to_users
        click_link 'Users'
      end
    end
  end
end
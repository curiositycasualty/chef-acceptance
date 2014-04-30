require 'spec_helper'
require 'capybara/dsl'

module Navigation
  include Capybara::DSL
  
  class Header  
    class << self
      def open_feedback_modal
        click_link 'span.usernav-section.report-bug'
      end

      def click_chef_logo
        click_link '#logo'
      end

      def sign_out
        click_link 'span.user-dropdown > div.dropdown > a.dropdown-toggle'
        find('li.logout').click
      end

      def go_to_administation
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
  # class Header < SitePrism::Section
  #   section :feedback_modal, Modal::Feedback, '#usernav' #not actually correct. should be the root of where the modal exists, not where it's opened.

  #   element :feedback_link, 'span.usernav-section.report-bug'
  #   element :user_dropdown, 'span.user-dropdown > div.dropdown > a.dropdown-toggle'
  #   element :chef_logo_link, '#logo'

    # debating whether methods like these are needed.
    # pro: if sequencing changes (multiple or consolidated steps) it's easier to maintain
    # con: redundant and adds another layer to capybara and siteprism DSLs. 
    # siteprism elements are solid
  # end

  # class Footer < SitePrism::Section
  # end
end
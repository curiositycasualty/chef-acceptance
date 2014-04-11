require 'pages/page_helper'

module Header

  class UserNav
    include Capybara::DSL
    
    def initialize
      @feedback_link = 'span.usernav-section.report-bug'
      @user_dropdown = 'span.user-dropdown > div.dropdown > a.dropdown-toggle > i.icon-caret-down'
      @user_semimodal = 'ul.dropdown-menu.semimodal-pullout'
      @sign_out_link = 'li.logout'
    end

    def open_feedback_modal
      find(@feedback_link).click
    end

    def sign_out
      find(@user_dropdown).click
      find(@user_semimodal).find(@sign_out_link).click
    end
  end

  class MainNav
    include Capybara::DSL
    def initialize
    end
  end
end
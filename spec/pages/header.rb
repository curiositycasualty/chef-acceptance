require 'pages/page_helper'

module Header

  class UserNav
    include Capybara::DSL
    
    def initialize
      @feedback_link = ''
      @user_dropdown = ''
      @sign_out_link = 'Sign Out'
    end

    def open_feedback_modal
      click_link @feedback_link
    end

    def sign_out
      click_link @user_dropdown
      click_link @sign_out_link
    end
  end

  class MainNav
    include Capybara::DSL
    def initialize
    end
  end
end
require 'spec_helper'

module Page
  class Login < SitePrism::Page
    set_url '/login'
      
    element :login_username_text, '#login-username'
    element :login_password_text, '#login-password'
    element :login_button, 'input.btn.btn-small'

    def login(username, password)
      login_username_text.set username
      login_password_text.set password
      login_button.click
    end
  end
end
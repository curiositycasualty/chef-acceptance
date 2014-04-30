require 'spec_helper'

module Page
  class Login < SitePrism::Page
    set_url '/login'
      
    element :login_username_input, '#login-username'
    element :login_password_input, '#login-password'
    element :login_button, 'input.btn.btn-small'

    def login(username, password)
      login_username_input.set username
      login_password_input.set password
      login_button.click
    end
  end
end
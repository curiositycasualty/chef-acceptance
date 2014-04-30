require 'spec_helper'

module Page
  class Login < SitePrism::Page
    set_url '/login'
      
    element :login_username, '#login-username'
    element :login_password, '#login-password'
    element :login_button, 'input.btn.btn-small'

    def login(username, password)
      login_username.set username
      login_password.set password
      login_button.click
    end
  end
end
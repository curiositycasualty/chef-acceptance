require 'spec_helper'

module Page
  class Login < SitePrism::Page
    set_url '/login'
      
    element :login_username_text, '#login-username'
    element :login_password_text, '#login-password'
    element :login_button, 'input.btn.btn-small'

    def login(login_factory)
      login_username_text.set login_factory.username
      login_password_text.set login_factory.password
      login_button.click
      return login_factory
    end
  end
end
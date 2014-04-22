require 'spec_helper'

module Page
  class Login < SitePrism::Page
    set_url '/login'
      
    element :login_username, '#login-username'
    element :login_password, '#login-password'
    element :login_button, 'input.btn.btn-small'
    
    element :signup_fullname, '#signup-display-name'
    element :signup_username, '#signup-username'
    element :signup_email, '#signup-email'
    element :signup_password, '#signup-password'
    element :signup_company, '#signup-company'
    element :signup_organization, '#signup-organization'
    element :signup_button, 'input.btn.btn-primary'

    def login(username, password)
      visit url
      login_username.set username
      login_password.set password
      login_button.click
    end

    def signup(fullname, username, email, password, organization, company = '')
      visit url
      signup_fullname.set fullname
      signup_username.set username
      signup_email.set email
      signup_password.set password
      signup_company.set company
      signup_organization.set organization
      signup_button.click
    end
  end
end
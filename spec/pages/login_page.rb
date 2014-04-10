require 'capybara'
require 'capybara/dsl'

class LoginPage
  include Capybara::DSL

  # todo: may need to create attr_readers
  def initialize
    @path = '/login'
    
    @login_username = 'login-username'
    @login_password = 'login-password'
    @login_button = 'Sign In'

    @signup_fullname = 'signup-display-name'
    @signup_username = 'signup-username'
    @signup_email = 'signup-email'
    @signup_password = 'signup-password'
    @signup_company = 'signup-company'
    @signup_organization = 'signup-organization'
    @signup_button = 'Get Started'
  end

  def login(username, password)
    visit @path
    fill_in @login_username, :with => username
    fill_in @login_password, :with => password
    click_button @login_button
  end

  def signup(fullname, username, email, password, organization, company = '')
    visit @path
    fill_in @signup_fullname, :with => fullname
    fill_in @signup_username, :with => username
    fill_in @signup_email, :with => email
    fill_in @signup_password, :with => password
    fill_in @signup_company, :with => company
    fill_in @signup_organization, :with => organization
    click_button @signup_button
  end

end
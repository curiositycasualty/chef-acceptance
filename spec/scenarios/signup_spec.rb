require 'spec_helper'
require 'pages/sign_up'
require 'sections/navigation'
require 'pages/roles'
require 'pages/clients'
require 'pages/login'
require 'pages/organizations'

include Navigation

feature 'Sign up users', :type => :feature do
  given(:sign_up_page) { Page::SignUp.new }
  given(:login_page) { Page::Login.new }
  given(:roles_page) { Page::Roles.new }
  given(:clients_page) { Page::Clients.new }
  given(:organizations_page) { Page::Organizations.new }

  scenario "host url redirects to sign up page" do
    Capybara.visit Capybara.app_host
    sign_up_page.should be_displayed
  end

  scenario "successfully sign up new user with an org and login" do
    user = FactoryGirl.build(:user)
    org = FactoryGirl.build(:org)
    
    sign_up_page.sign_up user, org
    Header.go_to_administration
    organizations_page.find_org(org.name)
    Header.sign_out
    login_page.wait_for_login_username_text
    login_page.login user
    expect(Header.signed_in_as).to have_content user.name
  end

end

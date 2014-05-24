require 'spec_helper'
require 'pages/sign_up'
require 'pages/roles'
require 'pages/clients'
require 'pages/login'
require 'pages/organizations'
require 'sections/navigation'

#include Navigation

describe 'Sign up users', :type => :feature, :sauce => true do
  # let(:sign_up_page) { Page::SignUp.new }
  # let(:login_page) { Page::Login.new }
  # let(:roles_page) { Page::Roles.new }
  # let(:clients_page) { Page::Clients.new }
  # let(:organizations_page) { Page::Organizations.new }

  before(:all) do
    @sign_up_page = Page::SignUp.new
    @login_page = Page::Login.new
    @roles_page = Page::Roles.new
    @clients_page = Page::Clients.new
    @organizations_page = Page::Organizations.new
  end

  # it "host url redirects to sign up page" do
  #   Capybara.visit Capybara.app_host
  #   @sign_up_page.should be_displayed
  # end

  it "successfully sign up new user with an org and login" do
    user = FactoryGirl.build(:user)
    org = FactoryGirl.build(:org)
    
    @sign_up_page.sign_up(user, org)
    Header.go_to_administration
    @organizations_page.find_org(org.name)
    Header.sign_out
    @login_page.wait_for_login_username_text
    @login_page.login user
    #expect(Header.signed_in_as).to have_content user.name # NOT WORKING due to low res

      # TODO perhaps we need to start considering low res testings
    find('div.usernav-section.user').find('div.dropdown').find('a.dropdown-toggle').click
    expect(page).to have_content "Signed in as #{user.name}"
  end

end

require 'spec_helper'

feature 'Sign up:', :sauce => ENV["RUN_ON_SAUCE"] do

  scenario "page is loaded when redirected from host url" do
    Capybara.visit Capybara.app_host
    sign_up_page.should be_displayed
  end

  scenario "new user can successfully sign up, create an org and login" do
    user = build(:user)
    org = build(:org)
    
    sign_up_page.sign_up(user, org)
    go_to_administration
    organizations_page.find_org(org.name)
    sign_out
    login_page.wait_for_login_username_text
    login_page.login user
    #expect(Header.signed_in_as).to have_content user.name # NOT WORKING due to low res

      # TODO perhaps we need to start considering low res testings
    find('div.usernav-section.user').find('div.dropdown').find('a.dropdown-toggle').click
    expect(page).to have_content 'Signed in as' #{user.name}"
    expect(page).to have_content user.name
  end

end

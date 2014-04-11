require 'spec_helper'

# todo: Include a module with all page objects instantiated
login_page = LoginPage.new
usernav = Header::UserNav.new

# todo: considering tracking current page automatically

describe "user login", :type => :feature do

  after(:each) do
    usernav.sign_out
  end

  it "allows user login" do
    # todo: data management -- coming
    login_page.login 'patrick', 'patrick'
    expect(page).to have_content 'Signed in aspatrick patrick'
  end

  it "allows user to sign up" do
    # todo: data management -- coming
    login_page.signup 'Joseph Smith', 'jsm', 'jsm@getchef.com', 'secret', 'jsm-test', 'Chef'
    expect(page).to have_content 'Signed in asJoseph Smith'
  end
end
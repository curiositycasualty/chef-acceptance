require 'spec_helper'

# todo: Include a module with all page objects instantiated
login_page = LoginPage.new

# todo: considering tracking current page automatically
page = login_page

describe "user login", :type => :feature do

  it "allows user login" do
    # todo: data management -- coming
    page.login 'patrick', 'patrick'
    expect(page).to have_content 'Signed in aspatrick patrick'
  end
end
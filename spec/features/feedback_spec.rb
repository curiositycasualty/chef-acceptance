require 'spec_helper'

# todo: Include a module with all page objects instantiated
login_page = LoginPage.new
usernav = Header::UserNav.new
feedback_modal = FeedbackModal.new

# todo: considering tracking current page automatically

describe "feedback", :type => :feature do

  after(:each) do
    usernav.sign_out
  end

  it "email contained in feedback modal" do
    login_page.login 'patrick', 'patrick'
    expect(page).to have_content 'Signed in aspatrick patrick'
    usernav.open_feedback_modal
    expect(feedback_modal.read_support_message).to have_content 'support@getchef.com'
  end
end
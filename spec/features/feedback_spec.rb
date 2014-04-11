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

    # we do not want to have such a generic page content search. this is just an example
    expect(page).not_to have_content 'support@getchef.com'
    usernav.open_feedback_modal
    expect(page).to have_content 'support@getchef.com'
    
    feedback_modal.close
  end
end
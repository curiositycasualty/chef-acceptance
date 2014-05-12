require 'spec_helper'
require 'sections/navigation'
require 'pages/login'
require 'sections/feedback_modal'

include Navigation

feature 'Header and footer sections', :type => :feature do
  given(:login_page) { Page::Login.new }

  scenario "verify feedback modals open via header" do
    login_page.login FactoryGirl.build(:user, username: 'chef')
    expect(page).not_to have_content 'support@getchef.com'
    Header.open_feedback_modal
    expect(page).to have_content 'support@getchef.com'
    expect(find('div.modal-body').find('a')[:href]).to eq('mailto:support@getchef.com?subject=Chef%20Management%20Console%20Feedback')
    Modal::Feedback.close
    expect(page).not_to have_content 'support@getchef.com'
  end

  scenario "verify feedback modals open via footer" do
    login_page.login FactoryGirl.build(:user, username: 'chef')
    expect(page).not_to have_content 'support@getchef.com'
    Footer.open_feedback_modal
    expect(page).to have_content 'support@getchef.com'
    expect(find('div.modal-body').find('a')[:href]).to eq('mailto:support@getchef.com?subject=Chef%20Management%20Console%20Feedback')
    Modal::Feedback.close
    expect(page).not_to have_content 'support@getchef.com'
  end
end

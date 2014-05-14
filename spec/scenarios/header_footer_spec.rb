require 'spec_helper'
require 'sections/navigation'
require 'pages/login'
require 'pages/organizations'
require 'sections/feedback_modal'

include Navigation

feature 'Header and footer sections', :type => :feature do
  given(:login_page) { Page::Login.new }
  given(:organizations_page) { Page::Organizations.new }

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
    pending 'awaiting pull request'
    login_page.login FactoryGirl.build(:user, username: 'chef')
    expect(page).not_to have_content 'support@getchef.com'
    Footer.open_feedback_modal
    expect(page).to have_content 'support@getchef.com'
    expect(find('div.modal-body').find('a')[:href]).to eq('mailto:support@getchef.com?subject=Chef%20Management%20Console%20Feedback')
    Modal::Feedback.close
    expect(page).not_to have_content 'support@getchef.com'
  end

  scenario 'user can switch between available orgs' do
    login_page.login FactoryGirl.build(:user, username: 'chef')
    Header.go_to_administration
    org1 = organizations_page.create_org
    org2 = organizations_page.create_org
    organizations_page.load # reload to populate orgs dropdown list
    Header.select_organization(org1.name)
    expect(Header.current_organization).to eq(org1.full_name)
    Header.go_to_policy
    expect(page.current_url).to include(org1.name)
    Header.select_organization(org2.name)
    expect(Header.current_organization).to eq(org2.full_name)
    expect(page.current_url).to include(org2.name)

    Header.manage_organizations
    organizations_page.find_org(org1.name)
    organizations_page.find_org(org2.name)
  end
end

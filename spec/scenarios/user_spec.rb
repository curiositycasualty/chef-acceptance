require 'spec_helper'

feature 'User:', :sauce => ENV["RUN_ON_SAUCE"] do

  scenario 'can switch between available orgs' do
    login_page.login FactoryGirl.build(:user, username: 'chef')
    go_to_administration
    org1 = organizations_page.create_org
    org2 = organizations_page.create_org
    organizations_page.load # reload to populate orgs dropdown list
    select_organization(org1.name)
    expect(current_organization).to eq(org1.full_name)
    go_to_policy
    expect(page.current_url).to include(org1.name)
    select_organization(org2.name)
    expect(current_organization).to eq(org2.full_name)
    expect(page.current_url).to include(org2.name)

    manage_organizations
    organizations_page.find_org(org1.name)
    organizations_page.find_org(org2.name)
  end

end

require 'spec_helper'
require 'pages/sign_up'
require 'sections/navigation'
require 'pages/roles'
require 'pages/clients'
require 'pages/login'
require 'pages/organizations'
require 'pages/data_bags'

include Navigation

feature 'Policy', :type => :feature do
  given(:sign_up_page) { Page::SignUp.new }
  given(:login_page) { Page::Login.new }
  given(:roles_page) { Page::Roles.new }
  given(:clients_page) { Page::Clients.new }
  given(:organizations_page) { Page::Organizations.new }
  given(:data_bags_page) { Page::DataBags.new }

  scenario "databags" do
    login_page.login FactoryGirl.build(:user, username: 'chef')
    Header.go_to_policy
    Policy.go_to_data_bags
    bag = data_bags_page.create_data_bag

    expect(data_bags_page.find_data_bag(bag).text).to eq(bag.name)
  end
end

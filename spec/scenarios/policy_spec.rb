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

  scenario "data bags" do
    login_page.login FactoryGirl.build(:user, username: 'chef')
    Header.go_to_policy
    Policy.go_to_data_bags
    bag = data_bags_page.create_data_bag
    expect(data_bags_page.find_data_bag(bag).text).to eq(bag.name)

    data_bags_page.select_data_bag(bag)
    item = data_bags_page.create_item
    puts "#{item.id}, #{item.attributes}"
    expect(data_bags_page.find_item(item).text).to eq(item.id)

    # edit item
    data_bags_page.select_item(item)
    json = { 'id' => "#{item.id}", 'toast' => 'jam'}
    data_bags_page.edit_selected_item(json)
    expect(data_bags_page.item_data_content.text).to eq("id: #{item.id} toast: jam")

    # delete item
    data_bags_page.select_item(item)
    data_bags_page.delete_selected_item
    expect(data_bags_page.find_item(item).text).not_to match(item.id)

    # delete databag
    data_bags_page.select_data_bag(bag)
    data_bags_page.delete_selected_data_bag
    expect(data_bags_page.find_item(item).text).not_to match(bag.name)
  end

  scenario 'search data bag items' do
  # add database

  # add 3 items - test1, test2, foo

  # filter 'test' - should display two items

  # filter 'foo' should display 1 item

  # filter 'none' - should display 0 items

  # clean field - should display 3 items
  end
end

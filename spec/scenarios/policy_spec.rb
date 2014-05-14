require 'spec_helper'
require 'sections/navigation'
require 'pages/login'
require 'pages/data_bags'

include Navigation

feature 'Policy', :type => :feature do
  given(:login_page) { Page::Login.new }
  given(:data_bags_page) { Page::DataBags.new }

  before(:each) do
    login_page.login FactoryGirl.build(:user, username: 'chef')
    Header.go_to_policy
    Policy.go_to_data_bags
  end

  scenario "data bags" do
    bag = data_bags_page.create_data_bag
    expect(data_bags_page.find_data_bag(bag).text).to eq(bag.name)

    data_bags_page.select_data_bag(bag)
    item = data_bags_page.create_item
    expect(data_bags_page.find_item(item).text).to eq(item.id)

    # edit item
    data_bags_page.select_item(item)
    data_bags_page.edit_selected_item( { 'id' => "#{item.id}", 'toast' => 'jam'} )
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
    pending 'in progress'
    bag = data_bags_page.create_data_bag

    # add 3 items - test1, test2, foo
    test1 = data_bags_page.create_item(FactoryGirl.build(:data_bag_item, id: 'test1'))
    data_bags_page.find_item(test1)
    test2 = data_bags_page.create_item(FactoryGirl.build(:data_bag_item, id: 'test2'))
    data_bags_page.find_item(test2)
    foo = data_bags_page.create_item(FactoryGirl.build(:data_bag_item, id: 'foo'))
    data_bags_page.find_item(foo)

    # filter 'test' - should display two items

    # filter 'foo' should display 1 item

    # filter 'none' - should display 0 items

    # clean field - should display 3 items
  end
end

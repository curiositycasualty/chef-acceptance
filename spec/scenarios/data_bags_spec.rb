require 'spec_helper'

feature 'Data bags', :sauce => ENV["RUN_ON_SAUCE"], :focus => true do

  before(:each) do
    login_page.login build(:user, username: 'chef')
    go_to_policy
    go_to_data_bags
  end

  scenario "items can be created, edited and deleted" do
    # create data bag
    bag = data_bags_page.create_data_bag build(:data_bag)

    # force solr index
    Solr.force_update
    
    expect(data_bags_page.find_data_bag(bag).text).to eq(bag.name)

    # create item
    data_bags_page.select_data_bag(bag)
    item = data_bags_page.create_item
    
    # force solr index
    Solr.force_update

    expect(data_bags_page.find_item(item).text).to eq(item.id)

    # edit item
    data_bags_page.select_item(item)
    data_bags_page.edit_selected_item( { 'id' => "#{item.id}", 'toast' => 'jam'} )
    expect(data_bags_page.item_data_content.text).to eq("id: #{item.id} toast: jam")

    # delete item
    data_bags_page.select_item(item)
    data_bags_page.delete_selected_item
    expect(data_bags_page.find_item(item)).to be_nil

    # delete databag
    data_bags_page.select_data_bag bag
    data_bags_page.delete_selected_data_bag
    expect(data_bags_page.find_item(item)).to be_nil
  end

  scenario 'items and be filtered using the search' do
    # create databag
    bag = data_bags_page.create_data_bag build(:data_bag)

    sleep 2
    # add 3 items - test1, test2, foo
    test1 = data_bags_page.create_item(build(:data_bag_item, id: 'test1'))
    test2 = data_bags_page.create_item(build(:data_bag_item, id: 'test2'))  
    foo = data_bags_page.create_item(build(:data_bag_item, id: 'foo'))

    # force solr index
    Solr.force_update

    # filter 'test' - should display two items
    expect(data_bags_page.search_item('test')).to match_array [test1.id, test2.id]

    # filter 'foo' should display 1 item
    expect(data_bags_page.search_item('foo')).to match_array [foo.id]

    # filter 'none' - should display 0 items
    expect(data_bags_page.search_item('none')).to match_array []

    # clean field - should display 3 items
    expect(data_bags_page.search_item('')).to match_array [test1.id, test2.id, foo.id]
  end
end

require 'spec_helper'

module Page
  class DataBags < SitePrism::Page
    set_url '/organizations{/org}/databags' 

    element :create_link, :xpath, "(//a[contains(text(),'Create')])[2]"
    element :delete_link, :xpath, "(//a[contains(text(),'Delete')])[2]"
    element :create_item_link, :xpath, "(//a[contains(text(),'Create Item')])[2]"
    element :data_bag_name_text, '#create-databag-name'
    element :create_data_bag_button, :xpath, '//button[@class="btn btn-submit btn-primary" and not(@disabled)]'
    element :create_data_bag_modal, 'div.modal'

    elements :data_bag_grid, '#list-pane div.slick-cell.l0.r0'

    def create_data_bag(data_bag_factory = FactoryGirl.build(:data_bag))
      wait_for_create_link
      create_link.click
      data_bag_name_text.set data_bag_factory.name
      create_data_bag_button.click
      wait_until_create_data_bag_modal_invisible
      return data_bag_factory
    end

    def delete_data_bag
    end

    def create_item
    end

    def find_data_bag(data_bag_factory)
      wait_for_data_bag_grid
      data_bag_grid.find do |bag|
        bag.text == data_bag_factory.name
      end
    end
  end
end

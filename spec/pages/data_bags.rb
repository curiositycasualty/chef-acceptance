require 'spec_helper'

module Page
  class DataBags < SitePrism::Page
    set_url '/organizations{/org}/databags' 

    element :create_data_bag_button, :xpath, '//button[@class="btn btn-submit btn-primary" and not(@disabled)]'
    element :create_data_bag_modal, 'div.modal'
    element :create_item_button, :xpath, '//button[@class="btn btn-submit btn-primary" and not(@disabled)]'
    element :create_item_link, :xpath, "(//a[contains(text(),'Create Item')])[2]"
    element :create_item_modal, 'div.modal'
    element :create_link, :xpath, "(//a[contains(text(),'Create')])[2]"
    element :data_bag_name_text, '#create-databag-name'
    element :delete_data_bag_button, '.btn.btn-yes.btn-danger'
    element :delete_data_bag_success_message, '.alert.alert-success'
    element :delete_item_button, '.btn.btn-danger'
    element :delete_item_link, 'div.item a.delete-item'
    element :delete_link, :xpath, "(//a[contains(text(),'Delete')])[2]"
    element :edit_item_link, 'div.item a.edit-item'
    element :item_attributes_text, 'textarea.attributes'
    element :item_data_content, '.databag-item-data'
    element :item_id_text, '#create-databag-item-id'
    element :item_search_text, '.databag-items #solr-search'
    element :item_search_button, '.search-filter button'
    element :modal, 'div.modal'
    element :modal_close_button, '.btn.btn-close'
    element :save_item_button, :xpath, '//button[@class="btn btn-primary" and not(@disabled)]'

    elements :data_bag_grid, 'div.ui-layout-container div.slick-cell.l0.r0'
    elements :item_grid, 'div.databag-items div.slick-cell.l0.r0'

    def create_data_bag(data_bag_factory = FactoryGirl.build(:data_bag))
      wait_for_create_link
      create_link.click
      data_bag_name_text.set data_bag_factory.name
      create_data_bag_button.click
      wait_until_create_data_bag_modal_invisible
      find_data_bag data_bag_factory
      return data_bag_factory
    end

    def find_data_bag(data_bag_factory)
      wait_for_data_bag_grid
      data_bag_grid.find do |bag|
        bag.text == data_bag_factory.name
      end
    end

    def select_data_bag(data_bag_factory)
      bag = find_data_bag(data_bag_factory)
      if bag.nil?
        raise 'Data bag not found, nothing to select' 
      else
        bag.click
      end
    end

    def delete_selected_data_bag
      wait_for_delete_link
      delete_link.click
      wait_for_delete_data_bag_button
      delete_data_bag_button.click
      wait_for_delete_data_bag_success_message
      modal_close_button.click
    end

    def create_item(data_bag_item_factory = FactoryGirl.build(:data_bag_item))
      wait_for_create_item_link
      create_item_link.click
      wait_for_item_id_text
      item_id_text.set data_bag_item_factory.id
      item_attributes_text.set data_bag_item_factory.attributes
      wait_for_create_item_button
      create_item_button.click
      wait_until_modal_invisible
      find_item(data_bag_item_factory)
      return data_bag_item_factory
    end

    def find_item(data_bag_item_factory)
      wait_for_item_grid
      item_grid.find do |item|
        item.text == data_bag_item_factory.id
      end
    end

    def select_item(data_bag_item_factory)
      item = find_item(data_bag_item_factory)
      if item.nil?
        raise 'Data bag item not found, nothing to select'
      else
        item.click
      end
    end

    def edit_selected_item(json_hash)
      wait_for_edit_item_link
      edit_item_link.click
      wait_for_item_attributes_text
      item_attributes_text.set json_hash.to_json
      save_item_button.click
    end

    def delete_selected_item
      wait_for_delete_item_link
      delete_item_link.click
      wait_for_delete_item_button
      delete_item_button.click
    end

    def search_item(name)
      wait_for_item_search_text
      item_search_text.set name
      item_search_button.click
      sleep 1
      wait_for_item_grid
      return item_grid.collect { |i|
        i.text
      }
    end
  end
end

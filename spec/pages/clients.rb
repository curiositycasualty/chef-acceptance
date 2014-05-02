require 'spec_helper'
require 'lib/util'

module Page
  class Clients < SitePrism::Page
    set_url '/organizations{/org}/clients'

    element :create_link, :xpath, "(//a[contains(text(),'Create')])[5]"
    element :delete_link, :xpath, "(//a[contains(text(),'Delete')])[5]"
    element :create_client_modal, 'div.modal.modal-client-create.in'
    element :client_name_text, '#client-user-name'
    element :create_client_button, :xpath, '//button[@class="btn btn-primary btn-create" and not(@disabled)]'
    element :private_key_content, 'pre.private_key'
    element :close_button, 'button.btn.btn-close'
    element :reset_key_link, 'a.rekey'
    element :reset_key_button, 'button.btn.btn-warning.btn-reset'
    element :reset_key_content, 'pre'

    elements :client_grid, '#list-pane div.slick-cell.l0.r0'

    def create_client(name, options = {})
      wait_for_create_link
      create_link.click
      wait_for_create_client_modal
      client_name_text.set name
      check('client-validator') if options[:validation]
      wait_for_create_client_button
      create_client_button.click

      wait_for_private_key_content

      key = private_key_content.text # returns all newlines as spaces

      close_button.click

      return Test::Util.format_to_rsa(key)
    end

    def find_client(name)
      client_grid.find do |client|
        client.text == name
      end
    end

    def select_client(name)
      wait_for_client_grid
      
      client = find_client name

      if client.nil?
        raise 'Client not found, nothing to select' 
      else
        client.click
      end
    end

    def reset_key
      reset_key_link.click

      wait_for_reset_key_button

      reset_key_button.click

      wait_for_reset_key_content

      key = reset_key_content.text # returns all newlines as spaces

      close_button.click

      return Test::Util.format_to_rsa(key)
    end
  end
end

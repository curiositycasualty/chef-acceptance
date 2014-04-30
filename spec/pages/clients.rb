require 'spec_helper'

module Page
  class Clients < SitePrism::Page
    set_url '/organizations{/org}/clients'

    element :create_link, 'a.create'
    element :delete_link, 'a.delete'
    element :create_client_modal, 'div.modal.modal-client-create.in'
    element :client_name_text, '#client-user-name'
    element :create_client_button, :xpath, '//button[@class="btn btn-primary btn-create" and not(@disabled)]'
    element :private_key_content, 'pre.private_key'
    element :close_button, 'button.btn.btn-close'

    def create(name)
      create_link.click
      wait_for_create_client_modal
      client_name_text.set name
      check('client-validator')
      wait_for_create_client_button
      create_client_button.click

      wait_for_private_key_content

      key = private_key_content.text
      
      close_button.click

      return key
    end

    def delete
    end
  end
end

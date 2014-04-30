require 'spec_helper'

module Page
  class Roles < SitePrism::Page
    set_url '/organizations{/org}/roles' 

    element :name_text, '#create-role-name'
    element :description_text, '#create-role-desc'
    element :create_org_button, :xpath, '//button[@class="btn btn-primary" and not(@disabled)]'
    element :create_link, 'a.create'
    elements :role_grid, '#list-pane div.slick-cell.l0.r0'
    element :role_modal, 'div.modal.in'

    # currently creates basic role
    def create(name, description)
      create_link.click

      wait_for_role_modal

      name_text.set name
      description_text.set description
      
      wait_for_create_org_button
      create_org_button.click
      
      wait_for_role_grid
    end

    def delete
    end

    def edit_run_list
    end

    def find_role(name)
      wait_for_role_grid
      
      role_grid.find do |role|
        role.text == name
      end
    end
  end
end
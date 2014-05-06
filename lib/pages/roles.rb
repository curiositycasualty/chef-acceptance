require 'spec_helper'
require 'sections/run_list_modal'

module Page
  class Roles < SitePrism::Page
    set_url '/organizations{/org}/roles{/role}' 

    element :name_text, '#create-role-name'
    element :description_text, '#create-role-desc'
    element :create_org_button, :xpath, '//button[@class="btn btn-primary" and not(@disabled)]'
    element :create_link, :xpath, "(//a[contains(text(),'Create')])[1]"
    element :delete_link, :xpath, "(//a[contains(text(),'Delete')])[1]"
    element :edit_run_list_link, 'a.editRunList'
    element :role_modal, 'div.modal.in'
    elements :role_grid, '#list-pane div.slick-cell.l0.r0'

    section :run_list_modal, Modal::RunList, 'div.modal.in'

    # currently creates basic role
    def create_role(role_factory = FactoryGirl.build(:role))
      create_link.click
      wait_for_role_modal
      name_text.set role_factory.name
      description_text.set role_factory.description
      wait_for_create_org_button
      create_org_button.click
      #wait_for_role_grid
      sleep 5
      return role_factory
    end

    def delete_role
    end

    def edit_run_list
      edit_run_list_link.click

      wait_for_run_list_modal

      sleep 3
    end

    def find_role(name)
      wait_for_role_grid
      
      role_grid.find do |role|
        role.text == name
      end
    end

    def select_role(name)
      role = find_role name
      role.click
    end
  end
end
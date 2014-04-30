require 'spec_helper'

module Page
  class Roles < SitePrism::Page
    set_url '/organizations{/org}/roles' 

    element :name, '#create-role-name'
    element :description, '#create-role-desc'
    element :create_role_button, 'button.btn.btn-primary'

    element :create_link, 'a.create'

    elements :roles, '#list-pane div.slick-cell.l0.r0'

    # currently creates basic role
    def create(role_name, role_description)
      create_link.click

      find ('div.modal.in')

      name.set role_name
      description.set role_description
      
      # BOOOOOOOOOOOOOOOOOOOO!!!!!!!!!!!!!!
      find(:xpath, '//button[@class="btn btn-primary" and not(@disabled)]').click
      
      wait_for_roles
    end

    def delete
    end

    def edit_run_list
    end

    def find_role(name)
      wait_for_roles

      match = roles.find do |role|
        role.text == name
      end

      raise 'Role not found' if match.nil?

      return match
    end

  end
end
require 'spec_helper'

module Modal
  class CreateOrg < SitePrism::Section   
    element :org_fullname_input, '#create-org-fullname'
    element :org_shortname_input, '#create-org-shortname'
    element :create_org_button, :xpath, '//button[@class="btn btn-submit btn-primary" and not(@disabled)]'
    element :cancel_button, 'button.btn.btn-close'
    element :modal, 'div.modal.in'

    def create(fullname, shortname)
      org_fullname_input.set fullname
      org_shortname_input.set shortname
      
      wait_for_create_org_button

      create_org_button.click

      sleep 5 # TODO:
    end
  end
end
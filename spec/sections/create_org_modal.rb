require 'spec_helper'

module Modal
  class CreateOrg < SitePrism::Section   
    element :org_fullname_input, '#create-org-fullname'
    element :org_shortname_input, '#create-org-shortname'
    element :create_org_button, 'button.btn.btn-submit.btn-primary'
    element :cancel_buton, 'button.btn.btn-close'

    def create(fullname, shortname)
      org_fullname_input.set fullname
      org_shortname_input.set shortname
      create_org_button.click
    end
  end
end
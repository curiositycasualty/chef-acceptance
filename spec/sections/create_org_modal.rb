require 'spec_helper'

module Modal
  class CreateOrg < SitePrism::Section   
    element :org_fullname, '#create-org-fullname'
    element :org_shortname, '#create-org-shortname'
    element :create_org, 'button.btn.btn-submit.btn-primary'
    element :cancel, 'button.btn.btn-close'

    def create(fullname, shortname)
      org_fullname.set fullname
      org_shortname.set shortname
      create_org.click
    end
  end
end
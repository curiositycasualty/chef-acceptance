require 'spec_helper'
require 'sections/create_org_modal'

module Page
  class Organizations < SitePrism::Page
    set_url '/organizations{/org}'

    elements :org_grid, '#list-pane div.slick-cell.l0.r0'
    element :create_link, 'a.create'

    section :create_org_modal, Modal::CreateOrg, 'div.modal.in'

    def find_org(name)
      org_grid.find do |org|
        org.text == name
      end
    end

    def select_org(name)
      org = find_org name

      if org.nil?
        raise 'Org not found, nothing to select' 
      else
        org.click
      end
    end

    def create(fullname, shortname)
      create_link.click

      create_org_modal.create fullname, shortname
    end
  end
end
require 'spec_helper'
require 'sections/create_org_modal'

module Page
  class Organizations < Page::ChefManage
    set_url '/organizations{/org}'

    elements :orgs, '#list-pane div.slick-cell.l0.r0'

    section :create_org_modal, Modal::CreateOrg, 'div.modal.in'

    def select_org(name)
      match = orgs.find do |org|
        org.text == name
      end

      raise 'Org not found' if match.nil?

      match.click
    end

    def create(org_full, org_short)
      #click create link
      click_link 'Create'

      create_org_modal.create org_full, org_short
    end
  end
end
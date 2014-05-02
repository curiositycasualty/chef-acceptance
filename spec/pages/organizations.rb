require 'spec_helper'
require 'sections/create_org_modal'
require 'lib/util'

module Page
  class Organizations < SitePrism::Page
    set_url '/organizations{/org}'

    element :create_link, 'a.create'
    element :reset_validation_key_link, 'a.rekey'
    element :reset_key_button, 'button.btn.btn-warning.btn-reset'
    element :reset_key_content, 'pre'
    element :close_button, 'button.btn.btn-close'

    elements :org_grid, '#list-pane div.slick-cell.l0.r0'

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

    def reset_key
      reset_validation_key_link.click

      wait_for_reset_key_button

      reset_key_button.click

      wait_for_reset_key_content

      key = reset_key_content.text # returns all newlines as spaces

      close_button.click

      return Test::Util.format_to_rsa(key)
    end
  end
end
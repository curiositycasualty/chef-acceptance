require 'spec_helper'

module Page
  class Users < SitePrism::Page
    set_url '/organizations{/org}/users'

    element :reset_key_link, 'a.rekey.pull-right'
    element :reset_key_button, 'button.btn.btn-warning.btn-reset'
    element :reset_key_content, 'div.modal-body pre'
    element :close_button, 'button.btn.btn-close'

    elements :user_grid, '#list-pane div.slick-cell.l0.r0'

    def find_user(name)
      user_grid.find do |user|
        user.text == name
      end
    end

    def select_user(name)
      wait_for_user_grid
      
      user = find_user name

      if user.nil?
        raise 'User not found, nothing to select' 
      else
        user.click
      end
    end

    def reset_key
      reset_key_link.click

      wait_for_reset_key_button

      reset_key_button.click

      wait_for_reset_key_content

      key = reset_key_content.text # returns all newlines as spaces

      close_button.click

      return Test::Util.format_to_rsa(key)
    end
  end
end

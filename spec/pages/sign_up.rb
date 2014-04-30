require 'spec_helper'
require 'sections/create_org_modal'

module Page
  class SignUp < SitePrism::Page
    set_url '/signup'

    # Sign Up landing page
    element :signup_fullname_input, '#signup-display-name'
    element :signup_username_input, '#signup-username'
    element :signup_email_input, '#signup-email'
    element :signup_password_input, '#signup-password'
    element :signup_company_input, '#signup-company'
    element :signup_button, 'button.btn.btn-primary'

    # Welcome modal - Create New Org or Accept Invite
    # Doesn't need to be a modal since it appears directly linear with this page
    element :create_new_org_button,'div.btn.btn-primary.btn-create'
    element :accept_invite_button, 'div.btn.btn-primary.btn-invite'
    element :refresh_icon, 'icon-refresh.pull-left'

    # Create Org modal
    section :create_org_modal, Modal::CreateOrg, 'div.modal.in'
    
    def sign_up(fullname, username, email, password, org_full, org_short, company = '')
      signup_fullname_input.set fullname
      signup_username_input.set username
      signup_email_input.set email
      signup_password_input.set password
      signup_company_input.set company
      signup_button.click

      create_new_org_button.click
      
      create_org_modal.create org_full, org_short
    end
  end
end

require 'spec_helper'
require 'sections/create_org_modal'

module Page
  class SignUp < SitePrism::Page
    set_url '/signup'

    # Sign Up landing page
    element :signup_fullname, '#signup-display-name'
    element :signup_username, '#signup-username'
    element :signup_email, '#signup-email'
    element :signup_password, '#signup-password'
    element :signup_company, '#signup-company'
    element :signup_button, 'button.btn.btn-primary'

    # Welcome modal - Create New Org or Accept Invite
    # Doesn't need to be a modal since it appears directly linear with this page
    element :create_new_org,'div.btn.btn-primary.btn-create'
    element :accept_invite, 'div.btn.btn-primary.btn-invite'
    element :refresh_icon, 'icon-refresh.pull-left'

    # Create Org modal
    section :create_org_modal, Modal::CreateOrg, 'div.modal.in'
    
    def sign_up(fullname, username, email, password, org_full, org_short, company = '')
      signup_fullname.set fullname
      signup_username.set username
      signup_email.set email
      signup_password.set password
      signup_company.set company
      signup_button.click

      create_new_org.click
      
      create_org_modal.create org_full, org_short
    end
  end
end

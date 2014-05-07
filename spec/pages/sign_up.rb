require 'spec_helper'
require 'sections/create_org_modal'

module Page
  class SignUp < SitePrism::Page
    set_url '/signup'

    # Sign Up landing page
    element :signup_fullname_text, '#signup-display-name'
    element :signup_username_text, '#signup-username'
    element :signup_email_text, '#signup-email'
    element :signup_password_text, '#signup-password'
    element :signup_company_text, '#signup-company'
    element :signup_button, 'button.btn.btn-primary'

    # Welcome modal - Create New Org or Accept Invite
    # Doesn't need to be a modal since it appears directly linear with this page
    element :create_new_org_button,'div.btn.btn-primary.btn-create'
    element :accept_invite_button, 'div.btn.btn-primary.btn-invite'
    element :refresh_icon, 'icon-refresh.pull-left'

    # Create Org modal
    section :create_org_modal, Modal::CreateOrg, 'div.modal.in'
    
    def sign_up(fullname, username, email, password, org_full, org_short, options = {})
      signup_fullname_text.set fullname
      signup_username_text.set username
      signup_email_text.set email
      signup_password_text.set password
      signup_company_text.set options[:company] if options[:company]
      signup_button.click
      create_new_org_button.click
      create_org_modal.create org_full, org_short
    end
  end
end

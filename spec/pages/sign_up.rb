require 'spec_helper'

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
    element :create_new_org,'div.btn.btn-primary.btn-create'
    element :accept_invite, 'div.btn.btn-primary.btn-invite'
    element :refresh_icon, 'icon-refresh.pull-left'

    # Create Org modal
    element :org_fullname, '#create-org-fullname'
    element :org_shortname, '#create-org-shortname'
    element :create_org, 'button.btn.btn-submit.btn-primary'
    element :cancel, 'button.btn.btn-close'

    def sign_up(fullname, username, email, password, org_full, org_short, company = '')
      signup_fullname.set fullname
      signup_username.set username
      signup_email.set email
      signup_password.set password
      signup_company.set company
      signup_button.click

      create_new_org.click
      
      org_fullname.set org_full
      org_shortname.set org_short
      create_org.click
    end
  end
end

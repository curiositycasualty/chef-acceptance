require 'spec_helper'
require 'sections/create_org_modal'

module Page
  class SignUp < SitePrism::Page
    set_url '/signup'
    set_url_matcher /signup/

    # Sign Up landing page
    element :signup_fullname_text, '#signup-display-name'
    element :signup_username_text, '#signup-username'
    element :signup_email_text, '#signup-email'
    element :signup_password_text, '#signup-password'
    element :signup_company_text, '#signup-company'
    element :signup_button, 'button.btn.btn-primary'

    # Welcome modal - Create New Org or Accept Invite
    # Doesn't need to be a section since it appears directly linear with this page
    element :create_new_org_button,'div.btn.btn-primary.btn-create'
    element :accept_invite_button, 'div.btn.btn-primary.btn-invite'
    element :refresh_icon, 'icon-refresh.pull-left'

    # Create Org modal
    section :create_org_modal, Modal::CreateOrg, 'div.modal.in'
    
    def sign_up(user_factory = FactoryGirl.build(:user), org_factory = FactoryGirl.build(:org))
      load
      signup_fullname_text.set user_factory.name
      signup_username_text.set user_factory.username
      signup_email_text.set user_factory.email
      signup_password_text.set user_factory.password
      signup_company_text.set user_factory.company
      signup_button.click
      create_new_org_button.click
      create_org_modal.create(org_factory.full_name, org_factory.name)
      return { :user => user_factory, :org => org_factory }
    end
  end
end

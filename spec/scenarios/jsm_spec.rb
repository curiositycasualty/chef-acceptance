require 'spec_helper'
require 'sections/navigation'
require 'pages/roles'
require 'pages/clients'
require 'pages/login'
require 'pages/organizations'

include Navigation
include Test

feature 'Node roles converge associated recipes', :type => :feature do
  given(:login_page) { Page::Login.new }
  given(:roles_page) { Page::Roles.new }
  given(:clients_page) { Page::Clients.new }
  given(:organizations_page) { Page::Organizations.new }

  scenario "new workflow" do
    login_page.load
    login_page.login FactoryGirl.build(:chef_login) # figure out default users

    Header.go_to_administration
    
    org = organizations_page.create_org
    ENV['CURRENT_ORG'] = org.name # need better approach to env vars

    # WORKAROUND because the org-validator is not always displayed navigating the pages BUG!
    clients_page.load(:org => org.name, :client => "#{org.name}-validator")

    # make this part of reset_key since we know the org
    Util.write_pem(org.name, clients_page.reset_key)

    Policy.go_to_roles
    role = roles_page.create_role

    # perhaps a single ChefMetal module
    Util::Metal.run 'client::vagrant,client::chef_server,client::cleanup,client::vagrant,client::machines'

    Util::Knife.upload 'cookbooks'
    Util::Knife.node 'run_list', "add jsmtest 'recipe[yum::test],role[#{role.name}]'"  
  end
end

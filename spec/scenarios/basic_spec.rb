require 'spec_helper'
require 'sections/navigation'
require 'pages/roles'
require 'pages/clients'
require 'pages/login'
require 'pages/organizations'

include Navigation

feature 'Node roles converge associated recipes', :type => :feature do
  given(:login_page) { Page::Login.new }
  given(:roles_page) { Page::Roles.new }
  given(:clients_page) { Page::Clients.new }
  given(:organizations_page) { Page::Organizations.new }

  scenario "new workflow" do
    login_page.login FactoryGirl.build(:user, username: 'chef') # figure out default users

    Header.go_to_administration
    
    org = organizations_page.create_org
    ENV['CURRENT_ORG'] = org.name # need better approach to env vars

    # WORKAROUND because the org-validator is not always displayed navigating the pages BUG!
    clients_page.load(:org => org.name, :client => "#{org.name}-validator")

    # Write a baked knife.rb with paths to generated keys, not just pem files
    #Util.write_pem(org.name, clients_page.reset_key)

    Policy.go_to_roles
    role = roles_page.create_role

    Header.sign_out # for good measure

    # Metal.run 'acceptance::vagrant,acceptance::chef_server,acceptance::cleanup,acceptance::machines'

    # Knife.upload 'cookbooks'
    # Knife.node 'run_list', "add jsmtest 'recipe[tests::basic_test],role[#{role.name}]'"  

    # # NEXT!
    # out = system("cd vagrant_vms && vagrant ssh jsmtest -c 'sudo chef-client' && vagrant ssh jsmtest -c 'cat /tmp/testfile' && cd ..")
    # puts out #heh
    # expect(out).to be true
  end
end

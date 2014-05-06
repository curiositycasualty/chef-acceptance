require 'spec_helper'
require 'pages/sign_up'
require 'sections/navigation'
require 'pages/roles'
require 'pages/clients'
require 'pages/users'
require 'pages/organizations'
require 'lib/util'
require 'pages/login'
require 'fileutils'

include Navigation

feature 'Node roles converge associated recipes', :type => :feature do
  #let(:ts) { Time.now.to_i.to_s }
  let(:sign_up_page) { Page::SignUp.new }
  let(:login_page) { Page::Login.new }
  let(:roles_page) { Page::Roles.new }
  let(:clients_page) { Page::Clients.new }
  let(:organizations_page) { Page::Organizations.new }
  let(:users_page) { Page::Users.new }

  before(:each) do
    @ts = Time.now.to_i.to_s
  end

  scenario "new workflow with #{@ts}" do
    puts @ts

    # log in with existing user
    login_page.load
    login_page.login 'chef', 'password'

    # create new org
    Header.go_to_administration
    
    org = "org#{@ts}"
    organizations_page.create_org "long #{org}", org
    ENV['CURRENT_ORG'] = org

    # for load org clients page to org validator
    # WORKAROUND because the org-validator is not always displayed navigating the pages BUG!
    clients_page.load(:org => org, :client => "#{org}-validator")
    # reset key and write to work/org-validator.pem
    validator_key = clients_page.reset_key

    FileUtils.mkdir_p "#{ENV['CHEF_TEST_DIR']}/work/pems"
    File.open("#{ENV['CHEF_TEST_DIR']}/work/pems/#{org}-validator.pem", "w") do |f|
      f.write "#{validator_key}"
    end

    system("#{ENV['CHEF_TEST_DIR']}/bin/knife upload -c #{ENV['CHEF_TEST_DIR']}/users/chef/.chef/knife.rb cookbooks")

   Policy.go_to_roles
   roles_page.create_role 'happyrole', "Role: #{@ts}"

# ADDING THIS VIA UI.... LATER
#    roles_page.select_role 'happyrole'
#    roles_page.load(:org => org, :role => 'happyrole') # force reload page to enable edit run list link BUG!
#    roles_page.edit_run_list
#    roles_page.run_list_modal.drag_available_recipe_to_run_list('yum::test')

    system("#{ENV['CHEF_TEST_DIR']}/bin/chef-client -z  -c #{ENV['CHEF_TEST_DIR']}/users/chef/.chef/knife.rb -o client::vagrant,client::chef_server,client::cleanup,client::vagrant,client::machines")

    system("#{ENV['CHEF_TEST_DIR']}/bin/knife node -c #{ENV['CHEF_TEST_DIR']}/users/chef/.chef/knife.rb run_list add jsmtest 'recipe[yum::test],role[happyrole]'")
    

  end
end

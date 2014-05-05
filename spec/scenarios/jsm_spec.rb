require 'spec_helper'
require 'pages/sign_up'
require 'sections/navigation'
require 'pages/roles'
require 'pages/clients'
require 'pages/users'
require 'pages/organizations'
require 'lib/util'
require 'pages/login'

require 'tempfile'

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

  scenario '' do
    pending
    sign_up_page.load
    sign_up_page.sign_up "full#{ts}", "user#{ts}", "email#{ts}@getchef.com", 'password', "org#{ts}", "org#{ts}"

    expect(page).to have_content "Signed in asfull#{ts}"

    ENV['CURRENT_ORG'] = "org#{ts}"
    ENV['CURRENT_USER'] = "user#{ts}"

    puts ENV['CURRENT_ORG'] = "org#{ts}"

    # option 1 - navigate links
    Header.go_to_policy
    Policy.go_to_roles

    #option 2 - direct page load
    # roles_page.load(org: ts)

    roles_page.create 'happyrole', "Role: #{ts}"

    #expect(roles_page.find_role('happyrole').text).to have_content 'happyrole'

    Policy.go_to_clients

    ##
    valid_key = clients_page.create_client("new-validator", {:validation => true})
    file = Tempfile.new "new-validator"
    file.write valid_key
    file.close
    ENV['VALID_KEY'] = file.path

    puts "KEY ----------------------- #{valid_key}"

    client_key = clients_page.create_client "new-client"
    file = Tempfile.new "new-client"
    file.write client_key
    file.close
    ENV['CLIENT_KEY'] = file.path

    Header.go_to_administration
    Administration.go_to_users

    users_page.select_user "user#{ts}"
    user_key = users_page.reset_key
    file = Tempfile.new "user"
    file.write user_key
    file.close
    ENV['USER_KEY'] = file.path

    system("#{ENV['CHEF_TEST_DIR']}/bin/chef-client -z -l debug -o client::vagrant,client::cleanup,client::machines")

    system("#{ENV['CHEF_TEST_DIR']}/bin/knife upload cookbooks")

  end


  scenario "new workflow with #{@ts}" do
    puts @ts

    # log in with existing user and client.pem
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

    File.open("#{ENV['CHEF_TEST_DIR']}/work/#{org}-validator.pem", "w") do |f|
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

# add a recipe to a role
# add that role to a specific client
# # save  



# create node (chef-metal)
# then the test 'calls out' to the node
# # runs chef-client
# reports back that the chef-client was successfully converged


# assumptions
# user exists with assigned permissions
# 
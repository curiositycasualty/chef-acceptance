require 'spec_helper'
require 'pages/sign_up'
require 'sections/navigation'
require 'pages/roles'
require 'pages/clients'
require 'pages/users'
require 'pages/organizations'
require 'lib/util'

require 'tempfile'

include Navigation

feature 'Node roles converge associated recipes', :type => :feature do
  let(:ts) { Time.now.to_i.to_s }
  let(:sign_up_page) { Page::SignUp.new }
  let(:roles_page) { Page::Roles.new }
  let(:clients_page) { Page::Clients.new }
  let(:organizations_page) { Page::Organizations.new }
  let(:users_page) { Page::Users.new }

  scenario '' do
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

    system("#{ENV['CHEF_TEST_DIR']}/bin/chef-client -z -o client::vagrant,client::cleanup,client::machines")

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
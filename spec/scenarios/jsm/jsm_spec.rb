require 'spec_helper'
require 'pages/sign_up'
require 'sections/navigation'
require 'pages/roles'
require 'pages/clients'

include Navigation

feature 'Node roles converge associated recipes', :type => :feature do
  let(:ts) { Time.now.to_i }
  let(:sign_up_page) { Page::SignUp.new }
  let(:roles_page) { Page::Roles.new }
  let(:clients_page) { Page::Clients.new }

  background(:all) do
    # set up node
  end

  scenario '' do
    sign_up_page.load
    sign_up_page.sign_up ts, ts, "#{ts}@getchef.com", 'password', ts, ts

    expect(page).to have_content "Signed in as#{ts}"

    # option 1 - navigate links
    Header.go_to_policy
    Policy.go_to_roles

    #option 2 - direct page load
    # roles_page.load(org: ts)

    roles_page.create 'happyrole', "Role: #{ts}"

    expect(roles_page.find_role('happyrole').text).to have_content 'happyrole'

    Policy.go_to_clients

    key = clients_page.create 'jsmtest'

    puts key
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
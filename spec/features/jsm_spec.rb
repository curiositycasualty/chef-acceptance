require 'spec_helper'
require 'pages/sign_up'
require 'sections/navigation'
require 'pages/roles'

include Navigation

feature 'Node roles converge associated recipes', :type => :feature do
  let(:ts) { Time.now.to_i }
  let(:sign_up_page) { Page::SignUp.new }
  let(:roles_page) { Page::Roles.new }

  background(:all) do
  end

  scenario '' do
    sign_up_page.load
    sign_up_page.sign_up ts, ts, "#{ts}@getchef.com", 'password', ts, ts, ''

    expect(page).to have_content "Signed in as#{ts}"

    go_to_policy # defaults to cookbooks page
    go_to_roles # skanky

    roles_page.create 'happyrole', "Role: #{ts}"

    expect(roles_page.find_role('happyrole').text).to have_content 'happyrole'
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
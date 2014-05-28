require 'spec_helper'

feature 'Environments:', :sauce => ENV["RUN_ON_SAUCE"] do

  before(:each) do
    login_page.login build(:user, username: 'chef')
    go_to_policy
  end

  scenario 'can be created with details' do
    go_to_environments

    # 1.  Select to create an environment.
    # 2.  Give the environment a name and description.
    # 3.  Select 3-4 cookbooks as well as constraints.
    # 4.  Enter default and override attributes.
    # 5.  Save the environment.
    # 6.  Verify the Environment shows in the environments list.
    env = environments_page.create_environment

    # 7.  Verify Description, cookbook constraints are as set.
    deets = environments_page.get_selected_details
    expect(deets[:name]).to eq(env.name)
    expect(deets[:description]).to eq(env.description)

    # 8.  Verify Attributes as set.
    # later
  end
end

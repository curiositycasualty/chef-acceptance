#equire 'spec_helper'
#require 'pages/sign_up'

# describe "sign up", :type => :feature do

#   before(:all) do
#     @id = "test_#{Time.now.to_i}"
#     puts "Using id: #{@id}"

#     sign_up_page = Page::SignUp.new
#     organization_page = Page::Organization.new(@id)
#   end

#   it "allows user to sign up and create an org" do
#     id = "test_#{Time.now.to_i}"
#     puts "Using id: #{id}"
#     sign_up_page.load
#     sign_up_page.sign_up id, id, "#{id}@getchef.com", 'password', id, 'org_short', ''

#     expect(page).to have_content "Signed in as#{id}"

#     organization_page.should be_displayed
#   end

# end
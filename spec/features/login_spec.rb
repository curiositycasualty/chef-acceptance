require 'spec_helper'

# app = ManageApp.new

# describe "user login", :type => :feature do

#   before(:all) do
#     @id = "test_#{Time.now.to_i}"
#     puts "Using id: #{@id}"
#     app.login_page.load
#     app.login_page.signup 'Patrick Wright', @id, "#{@id}@getchef.com", 'secret', @id, 'Chef'
#     app.admin_page.header.sign_out
#   end

#   after(:each) do
#     app.admin_page.header.sign_out
#   end

#   it "allows user login" do
#     # todo: data management -- coming
#     app.login_page.login @id, 'secret'
#     expect(page).to have_content 'Signed in asPatrick Wright'
#   end

#   it "allows user to sign up" do
#     # todo: data management -- coming
#     now=Time.now.to_i
#     app.login_page.signup 'Patrick Wright2', "patrick#{now}", "patrick#{now}@getchef.com", 'secret', "pw-test#{now}", 'Chef'
#     expect(page).to have_content 'Signed in asPatrick Wright2'
#   end

#   it "email contained in feedback modal" do
#     app.login_page.login @id, 'secret'

#     # we do not want to have such a generic page content search. this is just an example
#     expect(page).not_to have_content 'support@getchef.com'
#     app.admin_page.header.open_feedback_modal
#     expect(page).to have_content 'support@getchef.com'
#     app.admin_page.header.feedback_modal.close
#   end
# end
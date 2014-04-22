require 'spec_helper'


# todo: Include a module with all page objects instantiated
login_page = Page::Login.new
admin_page = Page::Administration.new

# todo: considering tracking current page automatically

describe "user login", :type => :feature do

  before(:all) do
    @id = "test_#{Time.now.to_i}"
    puts "Using id: #{@id}"
    login_page.load
    login_page.signup 'Patrick Wright', @id, "#{@id}@getchef.com", 'secret', @id, 'Chef'
    admin_page.header.sign_out
  end

  after(:each) do
    admin_page.header.sign_out
  end

  it "allows user login" do
    # todo: data management -- coming
    login_page.login @id, 'secret'
    expect(page).to have_content 'Signed in asPatrick Wright'
  end

  it "allows user to sign up" do
    # todo: data management -- coming
    now=Time.now.to_i
    login_page.signup 'Patrick Wright2', "patrick#{now}", "patrick#{now}@getchef.com", 'secret', "pw-test#{now}", 'Chef'
    expect(page).to have_content 'Signed in asPatrick Wright2'
  end

  it "email contained in feedback modal" do
    login_page.login @id, 'secret'

    # we do not want to have such a generic page content search. this is just an example
    expect(page).not_to have_content 'support@getchef.com'
    admin_page.header.open_feedback_modal
    expect(page).to have_content 'support@getchef.com'
    admin_page.header.feedback_modal.close
  end
end
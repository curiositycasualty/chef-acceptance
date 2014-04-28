require 'spec_helper'
require 'pages/sign_up'

sign_up = Page::SignUp.new

describe "sign up", :type => :feature do

  it "allows user to sign up and create an org" do
    id = "test_#{Time.now.to_i}"
    puts "Using id: #{id}"
    sign_up.load
    sign_up.sign_up id, id, "#{id}@getchef.com", 'password', id, 'org_short', ''
  end

end
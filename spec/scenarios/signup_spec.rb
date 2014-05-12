require 'spec_helper'
require 'pages/sign_up'

feature 'Sign up new users', :type => :feature do
  given(:sign_up_page) { Page::SignUp.new }

  scenario "new user" do
    sign_up_page.sign_up
  end
end

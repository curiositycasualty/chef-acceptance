require 'sections/feedback_modal'
require 'sections/navigation'

require 'pages/manage_page'

require 'pages/login_page'
require 'pages/administration_page'

# also expect knife, p-c-c, and db helpers!

class ManageApp
  def login_page
    Page::Login.new
  end

  def admin_page
    Page::Administration.new
  end
end
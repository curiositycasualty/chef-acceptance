require 'memoist'

require 'pages/clients'
require 'pages/cookbooks'
require 'pages/data_bags'
require 'pages/environments'
require 'pages/sign_up'
require 'pages/login'
require 'pages/roles'
require 'pages/organizations'
require 'pages/users'
require 'sections/header'
require 'sections/policy'
require 'sections/administration'


## This may be the core API reference, so lots of Ruby doc here and included modules

module ChefManageApp
  extend Memoist

  include Page
  include Header
  include Policy
  include Administration

  def clients_page
    Clients.new
  end
  memoize :clients_page

  def cookbooks_page
    Cookbooks.new
  end
  memoize :cookbooks_page

  def data_bags_page
    DataBags.new
  end
  memoize :data_bags_page

  def environments_page
    Environments.new
  end
  memoize :environments_page

  def sign_up_page
    SignUp.new  
  end
  memoize :sign_up_page

  def login_page
    Login.new
  end
  memoize :login_page

  def roles_page
    Roles.new
  end
  memoize :roles_page

  def organizations_page 
    Organizations.new
  end
  memoize :organizations_page

  def users_page
    Users.new
  end
  memoize :users_page
end

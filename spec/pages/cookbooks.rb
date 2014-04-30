require 'spec_helper'

module Page
  class Cookbooks < Page::ChefManage
    set_url '/organizations{/org}/cookbooks' 
  end
end

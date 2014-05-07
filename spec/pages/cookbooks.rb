require 'spec_helper'

module Page
  class Cookbooks < SitePrism::Page
    set_url '/organizations{/org}/cookbooks' 
  end
end

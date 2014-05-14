require 'spec_helper'

module Page
  class Environments < SitePrism::Page
    set_url '/organizations{/org}/environments'

    element :create_link, :xpath, "(//a[contains(text(),'Create')])[3]"

    def create_environment(FactoryGirl.build(:environment))# doesn't exist yet
      wait_for_create_link
      create_link.click
      # more stuff
    end
  end
end

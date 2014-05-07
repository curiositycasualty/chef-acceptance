require 'spec_helper'

module Modal
  class Feedback < SitePrism::Section   
    def close
      find('button.btn.btn-close').click
    end
  end
end
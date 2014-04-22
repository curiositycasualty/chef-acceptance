require 'spec_helper'

module Modal
  class Feedback < SitePrism::Section    
    def close
      find('button.btn.btn-close').click
    end

    def read_support_message
      support_message.text
    end
  end
end
require 'spec_helper'

module Modal
  class Feedback
    class << self
      def support_link
        find('div.modal-body').find('a')
      end 

      def close
        find('button.btn.btn-close').click
      end
    end
  end
end
require 'spec_helper'

module Navigation
  class Header < SitePrism::Section
    section :feedback_modal, Modal::Feedback, '#usernav'

    element :feedback_link, 'span.usernav-section.report-bug'
    element :user_dropdown, 'span.user-dropdown > div.dropdown > a.dropdown-toggle'

    def open_feedback_modal
      feedback_link.click
    end

    def sign_out
      user_dropdown.click
      find('li.logout').click # not siteprism compatible
    end
  end

  class Footer < SitePrism::Section
  end

  class Tabs < SitePrism::Section
  end
end
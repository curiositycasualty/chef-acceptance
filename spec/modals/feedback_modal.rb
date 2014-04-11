require 'pages/page_helper'

class FeedbackModal
  include Capybara::DSL

  @close_button = 'button.btn.btn-close'
  @x_button = 'i.icon-remove'
  @support_message_class = 'support-message'
  
  def close
    click_button @close_button
  end

  def read_support_message
    page.find('class', @support_message_class).value
  end

end
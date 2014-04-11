require 'pages/page_helper'

class FeedbackModal
  include Capybara::DSL

  @close_button = 'btn.btn-close'
  @x_button = ''
  @support_message = ''
  
  def close
    find_button(@close_button).click
  end

  # todo: get this to work
  def read_support_message
    find(@support_message).text
  end

end
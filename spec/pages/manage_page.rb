require 'spec_helper'

module Page
  class Manage < SitePrism::Page
    section :header, Navigation::Header, '#header'
    section :footer, Navigation::Footer, '#footer'
  end
end

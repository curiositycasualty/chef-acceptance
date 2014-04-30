#!/usr/bin/env ruby

$LOAD_PATH << './spec'

require 'spec_helper'

Capybara.visit Capybara.app_host

require 'pry'

binding.pry

# You should edit this file with the browsers you wish to use
# For options, check out http://saucelabs.com/docs/platforms
require "sauce"

# Set up configuration
Sauce.config do |c|
  c[:browsers] = [ 
    ["OS X 10.9", "Firefox", "28"]#,
    #['Windows 8.1', 'Firefox', '28']
    #['Windows 8.1', 'Internet Explorer', '11'], # bug with create org?
    #['Windows 7', 'Internet Explorer', '10'] # bug with create org?
    #['Windows 7', 'Internet Explorer', '8'] # bug with sign in or bad locator?

  ]
end


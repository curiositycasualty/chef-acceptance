chef-acceptance
===============

End to end Chef acceptance tests

## Currently Supports
 * vagrant nodes (chef-metal)
 * firefox
 * knife exec
 * Sauce

## Key Upcoming Features
 * headless browser
 * additional browser support (chrome, ie)
 * ec2 nodes
 * docker nodes
 * test-kitchen (kitchen-metal)

## Getting Started

### Environment
First you will need a running Enterprise Chef server up and running. Check out [ec-metal](https://github.com/opscode/ec-metal) for starting up EC HA.

### Configuration
Copy test-config.template.yml to test-config.yml

Set `app_host` to the chef server front-end url.

Set `search_host` to the active search node url.

Set `driver` to selenium.  No other are drivers currently supported.

Set `browser` to firefox.

Set `wait_time` to 5. Good starting point.

Temporary: Create a user with username `chef` and password `password`.  Create an org -- any name will do.

### Execution
```bash
rake bundle
```

#### rake tasks
 * `rake local` - runs tests on local workstation

#### Sauce tasks
You must have a Sauce account.  A free account will work just fine!

http://saucelabs.com/signup

 * `rake on_sauce` - runs tests on Sauce. Uses ondemand config: https://github.com/saucelabs/sauce_ruby/wiki/ondemand.yml
 * `rake parallel_on_sauce` - runs tests on Sauce in parallel: https://github.com/saucelabs/sauce_ruby/wiki/Concurrent-Testing
    * (SAUCE_USERNAME and SAUCE_ACCESS_KEY environments vars must be set for the parallel task)
 

### Sauce Browser Config
`browsers.yml` lists platform and browsers combinations that will be executed.

https://saucelabs.com/platforms

This yml file follows the following format for each combination:
```yaml
- ["OS", "Browser", "Version"]
```




### Sauce Cost Conservation
Remember that each test execution uses available platform and duration times.  For development, be sure to run tests locally.  When ready to run tests on Sauce only run tests of concern.

### TODO
 * each spec may have isolated cookbooks and misc files
 * configuration feature to either "sign up" a main user or use an existing account
 * improve dynamic knife execution. Should generate a knife file with static content
 * knife opc setup and cleanup support (pivotal)
 * continue refactoring env vars usage
 * some actions should be able to accept a string value or a factory object
 * refactor shared app objects like modals and the grid canvas objects
 * improve window handlers
 * ~~figure out best approach to preloading all page objects for each spec~~
 * ~~reorganize specs (features and scenarios) appropriately~~
 * refactor atrocious util library
 * add custom matcher for grid/find objects. LAME! expect(data_bags_page.find_data_bag(bag).text).to eq(bag.name)
    * fix grid selectors (handle empty alerts)
 * ~~lock down gem versions~~

### Test Results
 * rspec
 * junit - coming soon

### Test Clients
Some tests will need nodes in order to validate certain features.  This is handled dynamically with chef-metal.  The example currently used is weak, but shows that we can provision nodes during a test run using data collected from the tests.

### Development
During development of new pages and objects you'll find yourself in change-run-change-run mode.  For UI tests, this is incredibly painful.  This project comes equipped with a runtime console environment.

Run `rake console` and let it load (using the test-config options)

```ruby
require 'pages/login'

p = Page::Login.new

p.load

links = all('a')
```

### Tools
chef-acceptance uses many tools
 * Selenium Webdriver
 * Capybara
 * SitePrism
 * FactoryGirl
 * Faker
 * Sauce

### Standards and Conventions

### Environment Cleanup
Automated environment maintenance is yet to be implemented and included as part of this project.  For now, you can use knife-opc and the provided helper scripts.
 1. copy the pivotal.pem file from the chef server to `work/pivotal.pem`
 1. create `work/knife-opc.rb` - content example below

  ```ruby
  #knife-opc.rb
  node_name 'pivotal'
  client_key 'pivotal.pem'
  chef_server_root 'https://<chef-server-url>'
```

 1. cd to the scripts dir-- cuz I'm lazy
 1. `./delete_all_orgs.sh`


__Sayonara orgs!__

The delete_all_users will respectfully not delete the pivotal user or ponyville users.

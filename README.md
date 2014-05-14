chef-acceptance
===============

End to end Chef acceptance tests

### Currently Supports
 * vagrant nodes (chef-metal)
 * firefox
 * knife exec

#### Key Upcoming Features
 * headless browser
 * additional browser support (chrome, ie)
 * ec2 nodes
 * docker nodes
 * saucelabs integration
 * test-kitchen (kitchen-metal)

### Configuration
Copy test-config.template.yml to test-config.yml

Set `app_host` to the full URL path of chef server front-end.

Set `driver` to selenium.  No other drivers currently supported.

Set `browser` to firefox.  Maybe Chrome works... haven't tried it.

Set `wait_time` to 5.  Probably a good starting point.

Temporary: Create a user with username `chef` and password `password`.  Create an org -- any name will do.

### Execution
```bash
rake bundle # use binstubs

rake
```
### TODO
 * each spec may have isolated cookbooks and misc files
 * configuration feature to either "sign up" a main user or use an existing account
 * improve dynamic knife execution. Should generate a knife file with static content
 * knife opc setup and cleanup support (pivotal)
 * continue refactoring env vars usage
 * some actions should be able to accept a string value or a factory object
 * refactor shared app objects like modals and the grid canvas objects
 * improve window handlers
 * figure out best approach to preloading all page objects for each spec
 * reorganzie specs (features and scenarios) appropriately
 * refactor atrocious util library
 * add custom matcher for grid/find objects. LAME! expect(data_bags_page.find_data_bag(bag).text).to eq(bag.name)

### Factories
Using `factory_girl` (expand upon this later)

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

### Standards and Conventions

### Environment Cleanup
Automated environment maintenance is yet to be implemented and included as part of this project.  For now, you can use knife-opc and the provided helper scripts.
 1. copy the pivotal.pem file from the chef server to `work/pivotal.pem`
 1. create `work/knife-opc.rb` - content example below
 1. cd to the scripts dir-- cuz I'm lazy
 1. `./delete_all_orgs.sh`

```ruby
#knife-opc.rb
node_name 'pivotal'
client_key 'pivotal.pem'
chef_server_root 'https://<chef-server-url>'
```

__Sayonara orgs!__

The delete_all_users will respectfully not delete the pivotal user or ponyville users.

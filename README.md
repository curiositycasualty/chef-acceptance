chef-acceptance
===============

End to end Chef acceptance tests

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

rake berks_install # use binstubs

rake
```

### Test Clients
Some tests will need nodes in order to validate certain features.  This is handled dynamically with chef-metal.  The example currently used is weak, but shows that we can provision nodes during a test run using data collected from the tests.

### Development
During development of new pages and objects you'll find yourself in change-run-change-run mode.  For UI tests, this is incredibly painful.  This project comes equipped with a runtime console environment.

Run `rake console` and let it load (using the test-config options)

```ruby
require 'pages/login'

p = Page::Login.new

p.load
```

### Standards and Conventions

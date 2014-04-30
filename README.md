chef-acceptance
===============

End to end Chef acceptance tests

### Configuration
Copy test-config.template.yml to test-config.yml

Set `app_host` to the full URL path of chef server front-end.

Set `driver` to selenium.  No other drivers currently supported.

Set `browser` to firefox.  Maybe Chome works? Haven't tried it.

Set `wait_time` to 5.  Probably a good starting point.

### Execution
```
bundle install

rake spec
```

### Development
During development of new pages and objects you'll find yourself in change, run, change, mode.  For UI tests, this is incredible painful.  This project comes equipped with a runtime conosle environment.

Run `rake console` and let it load (using the test-config options)

```ruby
require 'pages/login'

p = Page::Login.new

p.load
```

### Standards and Conventions

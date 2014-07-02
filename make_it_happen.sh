#!/bin/bash

# clone
pushd /Users/patrickwright/Chef/github/opscode/ec-metal-clean

rake up

rake remote[backend1,"knife-opc user create chef chef chef chef@chef.com password"]

rake remote[backend1,"knife-opc org create cheforg cheforgdesc -a chef"]

# clone
pushd /Users/patrickwright/Chef/github/patrick-wright/chef-acceptance

rake on_sauce


#### ec-metal
# pre/post cleanup
# best approach to managing configurations https://github.com/patrick-wright/chef-acceptance-config
# write ec2 ip addresses to file
  ## write app_host (manage_fnqn) and search_host(boostrap backend) to properties file 
# paramterize package URLs / file references
# manage aws config for ec2

#### chef-acceptance
# first run of data bags tests fail - due to broken grid seaching logic in Pages
# best approach to managing test / browser configurations https://github.com/patrick-wright/chef-acceptance-config
# manage sauce ondemand vs ENV (parallel)
# junit output
# optimize config overrides (ENV)
# move from rake to thor for improved configuration control (get away from ENV where possible)

#### jobs
# consolidate ec-metal & chef-acceptance jobs
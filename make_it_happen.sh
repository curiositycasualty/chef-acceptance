#!/bin/bash

# clone
pushd /Users/patrickwright/Chef/github/opscode/ec-metal-clean

rake up

rake remote[backend1,"knife-opc user create chef chef chef chef@chef.com password"]

rake remote[backend1,"knife-opc org create cheforg cheforgdesc -a chef"]

# clone
pushd /Users/patrickwright/Chef/github/patrick-wright/chef-acceptance

rake on_sauce

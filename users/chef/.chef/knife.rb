# This file is used by chef-metal and knife
# Values are dynamic

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "chef"
client_key               "#{current_dir}/chef.pem"
validation_client_name   "#{ENV['CURRENT_ORG']}-validator"
validation_key           "#{ENV['CHEF_TEST_WORK']}/pems/#{ENV['CURRENT_ORG']}-validator.pem"
chef_server_url          "https://33.33.33.23/organizations/#{ENV['CURRENT_ORG']}"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{ENV['CHEF_TEST_DIR']}/cookbooks", "#{ENV['CHEF_TEST_WORK']}/vendor/cookbooks"]

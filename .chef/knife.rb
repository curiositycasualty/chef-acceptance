current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "#{ENV['CURRENT_USER']}"
client_key               "#{ENV['USER_KEY']}"
validation_client_name   "new-validator"
validation_key           "#{ENV['VALID_KEY']}"
chef_server_url          "https://33.33.33.23/organizations/#{ENV['CURRENT_ORG']}"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
verify_api_cert          false
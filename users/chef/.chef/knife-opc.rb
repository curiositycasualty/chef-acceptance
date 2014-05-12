current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "pivotal"
client_key               "#{current_dir}/chef.pem"
chef_server_root          "https://54.186.23.195/"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )

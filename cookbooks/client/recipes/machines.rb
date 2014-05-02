require 'chef/config'

with_chef_server "https://33.33.33.23/organizations/#{ENV['CURRENT_ORG']}", {
#  :client_name => Chef::Config[:node_name],
#  :signing_key_filename => Chef::Config[:client_key]
  :client_name => 'new-validator',
  :signing_key_filename => ENV['VALID_KEY']
}

machine 'jsmtest' do
  action :create
end
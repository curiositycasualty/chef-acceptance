require 'chef/config'

with_chef_server "#{node['test']['app_host']}/organizations/#{ENV['CURRENT_ORG']}", {
  :client_name => Chef::Config[:node_name],
  :signing_key_filename => Chef::Config[:client_key]
}

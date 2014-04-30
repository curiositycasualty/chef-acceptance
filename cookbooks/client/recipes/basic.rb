require 'chef_metal_vagrant'
require 'chef/config'
require 'capybara'

# Set up a vagrant cluster (place for vms) in ~/machinetest
vagrant_cluster "#{ENV['HOME']}/machinetest"

directory "#{ENV['HOME']}/machinetest/repo"
with_chef_local_server :chef_repo_path => "#{ENV['HOME']}/machinetest/repo"

# Use a Linux image
vagrant_box 'precise64' do
  url 'http://files.vagrantup.com/precise64.box'
#  provisioner_options 'vagrant_config' => <<EOM
#    config.vm.synced_folder (ENV['SRC_DIR'] || "#{ENV['HOME']}/oc/code/opscode"), "/mnt/host_src"
#EOM
end

machine 'jsmtest' do
end
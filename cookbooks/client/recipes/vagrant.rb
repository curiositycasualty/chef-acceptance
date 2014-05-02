require 'chef_metal_vagrant'
require 'chef_metal'

repo_path = node['test']['dir']
vms_dir = node['test']['vms_dir']

directory vms_dir
vagrant_cluster vms_dir

# with_chef_local_server :chef_repo_path => repo_path,
#   :cookbook_path => [ File.join(repo_path, 'cookbooks'),
#     File.join(repo_path, 'vendor', 'cookbooks') ]

# Use a Linux image
vagrant_box 'precise64' do
  url 'http://files.vagrantup.com/precise64.box'
#  provisioner_options 'vagrant_config' => <<EOM
#    config.vm.synced_folder (ENV['SRC_DIR'] || "#{ENV['HOME']}/oc/code/opscode"), "/mnt/host_src"
#EOM
end



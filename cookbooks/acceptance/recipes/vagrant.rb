require 'chef_metal_vagrant'

vagrant_cluster node['test']['vms_dir']

vagrant_box 'precise64' do
  url 'http://files.vagrantup.com/precise64.box'
end



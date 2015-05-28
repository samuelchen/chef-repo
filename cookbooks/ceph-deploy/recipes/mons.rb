unless node['ceph']['config']['fsid']
  require 'securerandom'
  node.set['ceph']['config']['fsid'] = SecureRandom.uuid
  node.save
end

unless node['ceph']['config']['mon_initial_members']
  node.set['ceph']['config']['mon_initial_members'] = node['hostname']
  node.save
end

unless node['ceph']['config']['mon_hosts']
  node.set['ceph']['config']['mon_hosts'] = node['ipaddress']
  node.save
end

template "#{node["ceph"]["clusterdir"]}/ceph.conf" do
  source 'ceph.conf.erb'
end

# create initial mon
execute "create-initial mon" do
  cwd node["ceph"]["clusterdir"]
  command "ceph-deploy mon create-initial #{node['hostname']}"
end

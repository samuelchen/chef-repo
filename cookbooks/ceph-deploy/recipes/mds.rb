node['ceph']['mds_hosts'].each do |mds|
  execute "install ceph on mons" do
    cwd node["ceph"]["clusterdir"]
    command "ceph-deploy mds create #{mds}"
  end
end

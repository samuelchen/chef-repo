# prepare osd
node['ceph']['osds'].each do |key, osd|
  execute "prepare osd" do
    cwd node['ceph']['clusterdir']
    command "ceph-deploy osd prepare #{osd['ipaddr']}:#{osd['device']}"
  end
end

# activate osd
node['ceph']['osds'].each do |key, osd|
  execute "prepare osd" do
    cwd node['ceph']['clusterdir']
    command "ceph-deploy osd activate #{osd['ipaddr']}:#{osd['device']}"
  end
end

# prepare keys ceph
node['ceph']['mons'].each do |mon|
  execute "gather keys" do
    cwd node['ceph']['clusterdir']
    command "ceph-deploy admin #{mon}"
  end
end

node['ceph']['osds'].each do |key, osd|
  execute "prepare osd" do
    cwd node['ceph']['clusterdir']
    command "ceph-deploy admin #{osd['ipaddr']}"
  end
end

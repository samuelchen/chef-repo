#
# Cookbook Name:: ceph-cookbook
# Recipe:: default
#

yum_repository "ceph-deploy" do
  description "Ceph Deploy Package Repository"
  baseurl "http://ceph.com/rpm-firefly/el6/noarch/"
  gpgkey "https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc"
  action :create
end

yum_package "ceph-deploy" do
  action :upgrade
  flush_cache [:before]
end

directory node["ceph"]["clusterdir"] do
  recursive true
  action :delete
end

directory node["ceph"]["clusterdir"] do
  owner "root"
  group "root"
  action :create
end

execute "ceph-deploy new #{node['hostname']}" do
  cwd node["ceph"]["clusterdir"]
end

# host key verification
node['ceph']['mons'].each do |mon|
  execute "add host key" do
    command "ssh-keyscan #{mon} >> /root/.ssh/known_hosts"
  end
end

node['ceph']['osds'].each do |key, osd|
  execute "add host key" do
    command "ssh-keyscan #{osd['ipaddr']} >> /root/.ssh/known_hosts"
  end
end

# install ceph
node['ceph']['mons'].each do |mon|
  execute "install ceph on mons" do
    command "ceph-deploy install #{mon}"
  end
end

node['ceph']['osds'].each do |key, osd|
  execute "install ceph on osds" do
    command "ceph-deploy install #{osd['ipaddr']}"
  end
end

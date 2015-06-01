#
# Cookbook Name:: euca.repo
# Recipe:: default
#
# Copyright (c) 2015 Samuel Chen, All Rights Reserved.


include_recipe 'selinux::disabled'
include_recipe 'euca.repo::webserver'

package 'createrepo'

directory '/var/www/html/euca-repo' do
  action :create
end

directory 'var/www/html/euca-repo/repodata' do
  action :delete
  recursive true
end

bash 'copy-file' do
  user 'root'
  cwd '/root'
  code <<-EOH
    #if [ -d '/var/www/html/euca-repo/repodata/' ]; then
    #  rm -rf /var/www/html/euca-repo/repodata
    #fi
    mount-vmware-share-folders.sh
    cp -ruv /mnt/VMShares/euca-repo/*  /var/www/html/euca-repo
  EOH
end

bash 'create-repo' do
  user 'root'
  cwd '/root'
  code <<-EOH
    createrepo --database /var/www/html/euca-repo
  EOH
end

#remote_directory 'euca-repo' do
#  path '/var/www/html/euca-repo'
#end



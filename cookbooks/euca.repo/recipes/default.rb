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

bash 'create-repo' do
  user 'root'
  cwd '/root'
  code <<-EOH
    files=`ls /var/www/html/euca-repo`
    if [ -d 'files' ]; then
      echo 'euca-repo is existed. /var/www/html/euca-repo'
    else
      createrepo --database /var/www/html/euca-repo
    fi
  EOH
end

#remote_directory 'euca-repo' do
#  path '/var/www/html/euca-repo'
#end

bash 'copy-file' do
  user 'root'
  cwd '/root'
  code <<-EOH
    mount-vmware-share-folders.sh
    cp -ruv /mnt/VMShares/euca-repo/*  /var/www/html/euca-repo
  EOH
end


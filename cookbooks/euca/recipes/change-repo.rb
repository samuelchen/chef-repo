#
# Cookbook Name:: euca
# Recipe:: change-repo
#
# Copyright (c) 2015 Samuel Chen, All Rights Reserved.


bash 'install-euca-repos' do
  user 'root'
  cwd '/root'
  code <<-EOH
    rpm -ivhF http://repo.euca/euca-repo/eucalyptus/downloads.eucalyptus.com/software/eucalyptus/4.1/centos/6/x86_64/eucalyptus-release-4.1.el6.noarch.rpm 
    rpm -ivhF http://repo.euca/euca-repo/euca2ools/downloads.eucalyptus.com/software/euca2ools/3.2/centos/6/x86_64/euca2ools-release-3.2.el6.noarch.rpm 
    rpm -ivhF http://repo.euca/euca-repo/eucalyptus/downloads.eucalyptus.com/software/eucalyptus/4.1/centos/6/x86_64/epel-release-6.noarch.rpm  
  EOH
end

bash 'change-baseurl' do
  user 'root'
  cwd '/etc/yum.repos.d/'
  code <<-EOH
    sed -i 's/^mirrorlist/#&/g' eucalyptus.repo

    flag=`grep baseurl eucalyptus.repo`
    if [ -d "$flag" ]; then
      echo 'baseurl=http://repo.euca/euca-repo/eucalyptus/downloads.eucalyptus.com/software/eucalyptus/4.1/centos/6/x86_64/\n' >> eucalyptus.repo
    fi

    sed -i 's/^mirrorlist/#&/g' euca2ools.repo
    flag=`grep baseurl euca2ools.repo`
    if [ -d "$flag" ]; then
      echo 'baseurl=http://repo.euca/euca-repo/euca2ools/downloads.eucalyptus.com/software/euca2ools/3.2/centos/6/x86_64/\n' >> euca2ools.repo
    fi
  EOH
end



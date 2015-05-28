#
# Cookbook Name:: euca.repo
# Recipe:: webserver
#
# Copyright (c) 2015 Samuel Chen, All Rights Reserved.


package 'httpd'

service 'httpd' do
  action [:enable, :start]
end

service 'iptables' do
  action [:stop, :disable]
end


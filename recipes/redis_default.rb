#
# Cookbook Name:: sensu_centos
# Recipe:: redis_default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "epel-update" do
  command "rpm -Uvh http://dl.fedoraproject.org/pub/epel/node['sensu_centos']['version_epel']/node['sensu_centos']['arq_epel']/node['sensu_centos']['release_epel']"
end

rpm_package "redis" do
  action :install
end

service "redis" do
  action [ :enable, :start ]
end
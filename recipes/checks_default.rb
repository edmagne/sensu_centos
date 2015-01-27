#
# Cookbook Name:: sensu_centos
# Recipe:: checks_default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "httpd"

service "httpd" do
  action [ :enable, :start ]
end

cookbook_file '/etc/sensu/plugins/check-apache.rb' do
  source 'check-apache.rb'
  owner "root"
  group "root"
  mode 00755
end

cookbook_file '/etc/sensu/conf.d/check_apache.json' do
  source 'check_apache.json'
  owner "root"
  group "root"
  mode 00755
end

service "sensu-server" do
  action [ :restart ]
end

service "sensu-api" do
  action [ :restart ]
end

service "sensu-client" do
  action [ :restart ]
end

service "uchiwa" do
  action [ :restart ]
end

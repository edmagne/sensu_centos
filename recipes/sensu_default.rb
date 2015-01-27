#
# Cookbook Name:: sensu_centos
# Recipe:: sensu_default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file '/etc/yum.repos.d/sensu.repo' do
  source 'sensu.repo'
  owner "root"
  group "root"
  mode 00644
end

package "sensu"
package "uchiwa"

service "sensu-server" do
  action [ :enable ]
end

service "sensu-api" do
  action [ :enable ]
end

service "sensu-client" do
  action [ :enable ]
end

service "uchiwa" do
  action [ :enable ]
end

directory '/etc/sensu/ssl/' do
  owner "root" 
  group "root"
  mode 00755
  action :create
end

execute "copy-client-key" do
  command "cp /root/joemiller.me-intro-to-sensu/client_key.pem /etc/sensu/ssl/"
end

execute "copy-client-cert" do
  command "cp /root/joemiller.me-intro-to-sensu/client_cert.pem /etc/sensu/ssl/"
end

template '/etc/sensu/conf.d/rabbitmq.json' do
  source 'rabbitmq.json.erb'
  owner "root"
  group "root"
  mode 00755
end

cookbook_file '/etc/sensu/conf.d/redis.json' do
  source 'redis.json'
  owner "root"
  group "root"
  mode 00755
end

cookbook_file '/etc/sensu/conf.d/api.json' do
  source 'api.json'
  owner "root"
  group "root"
  mode 00755
end

cookbook_file "/etc/sensu/uchiwa.json" do
  action :delete
end

cookbook_file '/etc/sensu/uchiwa.json' do
  source 'uchiwa.json'
  owner "root"
  group "root"
  mode 00755
end

cookbook_file '/etc/sensu/conf.d/client.json' do
  source 'client.json'
  owner "root"
  group "root"
  mode 00755
end

service "sensu-server" do
  action [ :start ]
end

service "sensu-api" do
  action [ :start ]
end

service "sensu-client" do
  action [ :start ]
end

service "uchiwa" do
  action [ :start ]
end
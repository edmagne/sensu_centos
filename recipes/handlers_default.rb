#
# Cookbook Name:: sensu_centos
# Recipe:: handlers_default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "wget"

execute "wget-handler-mailer-ses" do
  command "wget -O /etc/sensu/handlers/mailer-ses.rb https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/handlers/notification/mailer-ses.rb"
end

file '/etc/sensu/handlers/mailer-ses.rb' do
  mode "0755"
end

cookbook_file '/etc/sensu/conf.d/mailer-ses.json' do
  source 'mailer-ses.json'
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

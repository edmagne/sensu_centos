#
# Cookbook Name:: sensu_centos
# Recipe:: handlers_default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

rpm_package "wget" do
  action :install
end

execute "wget-handler-mailer-ses" do
  command "wget -O /etc/sensu/handlers/mailer-ses.rb https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/handlers/notification/mailer-ses.rb"
end

execute "wget-conf-mailer-ses" do
  command "wget -O /etc/sensu/conf.d/mailer-ses.json https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/handlers/notification/mailer-ses.json"
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
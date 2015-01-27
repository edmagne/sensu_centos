#
# Cookbook Name:: sensu_centos
# Recipe:: rabbitmq_default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "epel-update" do
  command "rpm -Uvh http://dl.fedoraproject.org/pub/epel/#{node['sensu_centos']['version_epel']}/#{node['sensu_centos']['arq_epel']}/#{node['sensu_centos']['release_epel']}"
end

package "git"
package "erlang"
package "logrotate"

execute "import-key-rabbitmq" do
  command "rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc"
end

execute "install-rabbitmq" do
  command "rpm -Uvh http://www.rabbitmq.com/releases/rabbitmq-server/#{node['sensu_centos']['release_rabbitmq']}/#{node['sensu_centos']['version_rabbitmq']}"
end

execute "clone-repo-joemiller" do
  command "git clone git://github.com/joemiller/joemiller.me-intro-to-sensu.git -l /root/joemiller.me-intro-to-sensu/"
end

execute "clean-ssl-certs" do
  cwd "/root/joemiller.me-intro-to-sensu/"
  command "sh ssl_certs.sh clean"
end

execute "generate-ssl-certs" do
  cwd "/root/joemiller.me-intro-to-sensu/"
  command "sh ssl_certs.sh generate"
end

directory '/etc/rabbitmq/ssl' do
  owner "root" 
  group "root"
  mode 00755
  action :create
end

execute "copy-server-key" do
  command "cp /root/joemiller.me-intro-to-sensu/server_key.pem /etc/rabbitmq/ssl/"
end

execute "copy-server-cert" do
  command "cp /root/joemiller.me-intro-to-sensu/server_cert.pem /etc/rabbitmq/ssl/"
end

execute "copy-cacert" do
  command "cp /root/joemiller.me-intro-to-sensu/testca/cacert.pem /etc/rabbitmq/ssl/"
end

cookbook_file '/etc/rabbitmq/rabbitmq.config' do
  source 'rabbitmq.config'
  owner "root"
  group "root"
  mode 00644
end

execute "rabbitmq-plugins-enable" do
  command "rabbitmq-plugins enable rabbitmq_management"
end

service "rabbitmq-server" do
  action [ :enable, :start ]
end

execute "rabbitmq-plugins-enable" do
  command "rabbitmq-plugins enable rabbitmq_management"
end

execute "rabbitmq-plugins-enable" do
  command "rabbitmq-plugins enable rabbitmq_management"
end

execute "rabbitmqctl-add-vhost" do
  command "rabbitmqctl add_vhost #{node['sensu_centos']['rabbitmqctl_vhost']}"
end

execute "rabbitmqctl-add-user" do
  command "rabbitmqctl add_user #{node['sensu_centos']['rabbitmqctl_user']} #{node['sensu_centos']['rabbitmqctl_pass']}"
end

execute "rabbitmqctl-add-pass" do
  command "rabbitmqctl set_permissions -p #{node['sensu_centos']['rabbitmqctl_vhost']} #{node['sensu_centos']['rabbitmqctl_user']} \".*\" \".*\" \".*\""
end

#
# Cookbook Name:: sensu_centos
# Recipe:: ruby_default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "yum-update" do
  command "yum update -y"
end

execute "yum-install-devel-tools" do
  command "yum -y groupinstall \"Development Tools\""
end

rpm_package "wget" do
  action :install
end

rpm_package "tar" do
  action :install
end

rpm_package "gcc-c++" do
  action :install
end

rpm_package "patch" do
  action :install
end

rpm_package "readline" do
  action :install
end

rpm_package "readline-devel" do
  action :install
end

rpm_package "zlib" do
  action :install
end

rpm_package "zlib-devel" do
  action :install
end

rpm_package "libff" do
  action :install
end

rpm_package "libyaml" do
  action :install
end

rpm_package "libyaml-devel" do
  action :install
end

rpm_package "openssl-devel" do
  action :install
end

bash "install_ruby" do
  user "root"
  cwd "/root"
  code <<-EOH
    wget http://ftp.ruby-lang.org/pub/ruby/1.9/#{node['sensu_centos']['version_ruby']}.tar.gz
    tar xvzf #{node['sensu_centos']['version_ruby']}.tar.gz
    (cd #{node['sensu_centos']['version_ruby']} && ./configure && make && make install)
  EOH
end

bash "install_rubygems" do
  user "root"
  cwd "/root"
  code <<-EOH
    wget http://production.cf.rubygems.org/rubygems/#{node['sensu_centos']['version_rubygems']}.tgz
    tar xvzf #{node['sensu_centos']['version_rubygems']}.tgz
    (cd #{node['sensu_centos']['version_rubygems']} && ruby setup.rb)
  EOH
end

execute "gem-update" do
  command "gem update --system"
end

gem_package 'sensu-plugin' do
  action :install
end

gem_package 'aws-ses' do
  action :install
end

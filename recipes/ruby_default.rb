#
# Cookbook Name:: sensu_centos
# Recipe:: ruby_default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "yum update -y"
execute "yum -y groupinstall \"Development Tools\""

package "wget"
package "tar"
package "gcc-c++"
package "patch"
package "readline"
package "readline-devel"
package "zlib"
package "zlib-devel"
package "libffi"
package "libffi-devel"
package "libyaml"
package "libyaml-devel"
package "openssl-devel"

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

execute "gem update --system"

gem_package 'sensu-plugin'
gem_package 'aws-ses'

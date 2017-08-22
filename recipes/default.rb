#
# Cookbook:: task1_jboss
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe 'java'

package 'unzip' do
  action :install
end

package 'net-tools' do
  action :install
end

template '/etc/systemd/system/wildfly.service' do
  source 'wildfly.service.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

bash 'extract_wildfly' do
  code <<-EOH
    unzip /tmp/chef-pkgs/wildfly-10.1.0.Final.zip -d /opt
    mv /opt/wildfly-10.1.0.Final /opt/wildfly
    EOH
  not_if { ::File.exist?('/opt/wildfly') }
end

bash 'extract_helloworld' do
  code <<-EOH
    unzip -u /tmp/chef-pkgs/HelloWorldWebApp.zip -d /opt/wildfly/standalone/deployments
    EOH
  not_if { ::File.exist?('/opt/wildfly/standalone/deployments/HellowWorld') }
end

service 'wildfly' do
  action [ :enable, :start ]
  supports :reload => true
end

bash 'wait_60_seconds' do
  code <<-EOH
    sleep 60
    EOH
end


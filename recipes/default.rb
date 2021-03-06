#
# Cookbook:: task1_jboss
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe 'java'
include_recipe 'task3_database'

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
  notifies :run, 'execute[systemctl_daemonreload]', :immediately
end

execute 'systemctl_daemonreload' do
  command 'systemctl daemon-reload'
  action :nothing
end

remote_file '/tmp/wildfly-10.1.0.Final.zip' do
  source 'http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.zip'
  action :create
end

bash 'extract_wildfly' do
  code <<-EOH
    unzip /tmp/wildfly-10.1.0.Final.zip -d /opt
    mv /opt/wildfly-10.1.0.Final /opt/wildfly
    EOH
  not_if { ::File.exist?('/opt/wildfly') }
end

include_recipe 'task1_jboss::deploy'

service 'wildfly' do
  action [ :enable, :start ]
  supports :reload => true
end

bash 'wait_60_seconds' do
  code <<-EOH
    sleep 60
    EOH
end


#
# Cookbook:: task1_jboss
# Recipe:: deploy
#
# Copyright:: 2017, The Authors, All Rights Reserved.
bash 'download_helloworld' do
  cwd '/tmp'
  code <<-EOH
    wget -N http://centerkey.com/jboss/HelloWorldWebApp.zip
    EOH
  not_if { ::File.exist?('/tmp/HelloWorldWebApp.zip') }
end


bash 'extract_helloworld' do
  code <<-EOH
    unzip -u /tmp/HelloWorldWebApp.zip -d /opt/wildfly/standalone/deployments
    EOH
  not_if { ::File.exist?('/opt/wildfly/standalone/deployments/HellowWorld') }
end

service 'wildfly' do
  action [ :restart ]
end

bash 'wait_30_seconds' do
  code <<-EOH
    sleep 30
    EOH
end


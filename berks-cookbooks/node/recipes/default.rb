#
# Cookbook:: node
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Install nginx, python, ruby this is where the code will be.

apt_update 'update_sources' do
  action :update
end

package 'nginx'
package 'nodejs'
service 'nginx' do
  action [:enable, :start]
end

template '/etc/nginx/sites-available/proxy.conf' do
  source 'proxy.conf.erb'
  variables proxy_port: node['nginx']['proxy_port'] # when it is calling the porxy.conf.erb it knows that variable which has values stored in another file in our case the node cookbook.
  notifies :restart, 'service[nginx]' # when it starts it will be listening already so we need to restart it to listen to another port.
end

link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available/proxy.conf'
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]'
end

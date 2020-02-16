#
# Cookbook:: nodejsapp-db-chef-azure
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

# imports of recipes
include_recipe 'apt'
include_recipe 'nodejs'


#packages apt-get
apt_update 'update_sources' do
  action :update
end

# #pm2 install
# nodejs_npm 'pm2'

# package 'npm'
package 'nginx'

# Deletes the default nginx file
file '/etc/nginx/sites-available/default' do
  owner 'root'
  group 'root'
  action :delete
end

# resource template
template '/etc/nginx/sites-available/default' do
  source 'proxy.conf.erb'
  variables proxy_port: node['nginx']['proxy_port']
end


# resource link
link '/etc/nginx/sites-enabled/default' do
  to '/etc/nginx/sites-available/default'
end

# link '/etc/nginx/sites-enabled/default' do
#   action :delete
# end

bash 'restart nginx' do
  user 'root'
  code <<-EOH
sudo systemctl restart nginx
    EOH
end

remote_directory '/home/ubuntu/app' do
  source 'app'
  owner 'root'
  group 'root'
  mode '0777'
  recursive true
  action :create
end

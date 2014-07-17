#
# Cookbook Name:: yoshiso-nvm
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install Setting
template '/etc/profile.d/nvm.sh' do
  source  'nvm.sh'
  owner   'root'
  mode    0755
  variables({version: node['nvm']['version']})
end

home = File.expand_path("~#{node['nvm']['user']}")

bash "install nvm"   do
  code "git clone git://github.com/creationix/nvm.git #{home}/.nvm &&
    source #{home}/.nvm/nvm.sh &&
    nvm install v#{node['nvm']['version']} &&
    nvm alias default #{node['nvm']['version']}"
  user node['nvm']['user']
  action :run
  not_if { ::File.exists?("#{home}/.nvm/nvm.sh") }
end

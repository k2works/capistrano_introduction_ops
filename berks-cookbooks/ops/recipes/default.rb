#
# Cookbook Name:: ops
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# nginx環境
package "nginx" do
  action :install
end

service "nginx" do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end

template 'nginx.conf' do
  path '/etc/nginx/nginx.conf'
  source "nginx.conf.erb"
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, "service[nginx]"
end

# デプロイ環境
group 'deploy' do
  group_name 'deploy'
  gid 999
  action :create
end

user 'deploy' do
  comment 'deploy user'
  group 'deploy'
  home '/home/deploy'
  shell '/bin/bash'
  supports :manage_home => true
  action :create
end
# 公開鍵の登録
directory "/home/deploy/.ssh/" do
  owner 'deploy'
  group 'deploy'
  mode 0755
end

cookbook_file "/home/deploy/.ssh/authorized_keys" do
  owner 'deploy'
  mode 0600
  source "deploy.authorized_keys.pub"
end
# 公開ディレクトの設定
directory "#{node['app']['deploy_to']}" do
  owner 'deploy'
  group 'deploy'
end

bash "SetupForDeployDirectory" do
  user 'deploy'
  cwd "#{node['app']['deploy_to']}"
  command "umask 0002"
  command "chmod g+s #{node['app']['deploy_to']}"
end

directory "#{node['app']['deploy_to']}/releases" do
  owner 'deploy'
  group 'deploy'
end

directory "#{node['app']['deploy_to']}/shared" do
  owner 'deploy'
  group 'deploy'
end

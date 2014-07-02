# Rails関連ライブラリ
%w{git libssl-dev libsqlite3-dev libmysqlclient-dev}.each do |pkg|
  package pkg do
    action :install
  end
end
# nodejs環境
remote_file "/tmp/#{node['nodejs']['filename']}" do
  source "#{node['nodejs']['remote_uri']}"
end

bash "install nodejs" do
  user "root"
  cwd "/tmp"
  code <<-EOC
    tar xvzf #{node['nodejs']['filename']}
    cd #{node['nodejs']['dirname']}
    make
    make install
  EOC
end
# RVM環境
bash "SetupRvm" do
 code <<-EOH
  usermod -a -G rvm deploy
  umask 002
  source /etc/profile.d/rvm.sh
  EOH
end
=begin
bash "InstallRvmForDeploy" do
  user 'deploy'
  code <<-EOH
    unset GEM_HOME
    export GEM_HOME=/usr/local/rvm/gems/ruby-2.1.0:/opt/chef/embedded/lib/ruby/gems/1.9.1
    unset GEM_PATH
    export GEM_PATH=/usr/local/rvm/gems/ruby-2.1.0:/usr/local/rvm/gems/ruby-2.1.0@global:/opt/chef/embedded/lib/ruby/gems/1.9.1
    rvm install #{node['rvm']['app_version']}
    rvm gemset create #{node['rvm']['app_gemset']}
    rvm --default use #{node['rvm']['app_version']}@#{node['rvm']['app_gemset']}"
    EOH
end

rvm_ruby "#{node['rvm']['app_version']}" do
  user 'deploy'
  action :install
end

rvm_gemset "#{node['rvm']['app_gemset']}" do
  ruby_string "#{node['rvm']['app_version']}"
  user 'deploy'
  action :create
end

rvm_default_ruby "#{node['rvm']['app_version']}@#{node['rvm']['app_gemset']}" do
  user 'deploy'
  action :create
end
=end

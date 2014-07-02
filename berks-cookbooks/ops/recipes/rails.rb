# ruby環境
%w{git libssl-dev libsqlite3-dev libmysqlclient-dev}.each do |pkg|
  package pkg do
    action :install
  end
end

=begin
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

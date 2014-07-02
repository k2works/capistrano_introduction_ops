default['rvm']['default_ruby'] = "ruby-2.1.0"
default['rvm']['app_version'] = "#{default['rvm']['default_ruby']}"
default['rvm']['app_gemset'] = "capistrano_introduction"

default['nodejs']['version'] = "v0.10.26"
default['nodejs']['dirname'] = "node-#{default['nodejs']['version']}"
default['nodejs']['filename'] = "#{default['nodejs']['dirname']}.tar.gz"
default['nodejs']['remote_uri'] = "http://nodejs.org/dist/#{default['nodejs']['version']}/#{default['nodejs']['filename']}"

default['app']['deploy_to'] = '/usr/share/nginx/www/capistrano_introduction'

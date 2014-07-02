default['rvm']['app_version'] = "ruby-2.1.0"
default['rvm']['app_gemset'] = "capistrano_introduction"
default['rvm']['user_installs'] = [
  { 'user'          => 'deploy',
    'default_ruby'  => 'ruby-2.1.0'
  }
]
default['rvm']['gemset'] = [
  { 'user' => 'deploy',
    'name' => 'capistrano_introduction'
  }
]
  'ruby-2.1.0' => [
    {'name' => 'capistrano_introduction'}
  ]
}
default['rvm']['user_default_ruby'] = "#{default['rvm']['app_version']}@#{default['rvm']['app_gemset']}"

default['nodejs']['version'] = "v0.10.26"
default['nodejs']['dirname'] = "node-#{default['nodejs']['version']}"
default['nodejs']['filename'] = "#{default['nodejs']['dirname']}.tar.gz"
default['nodejs']['remote_uri'] = "http://nodejs.org/dist/#{default['nodejs']['version']}/#{default['nodejs']['filename']}"

default['app']['deploy_to'] = '/usr/share/nginx/www/capistrano_introduction'

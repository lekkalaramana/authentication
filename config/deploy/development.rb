

server '13.228.79.96',
  user: 'ubuntu',
  roles: %w{app web app},
  ssh_options: {
  	forward_agent: true,
  }																																	

set :stage, :development
set :branch, :master
set :ssh_options, {:forward_agent => true}

# Setting RAILS_ENV environment variable on server
set :rails_env, :development


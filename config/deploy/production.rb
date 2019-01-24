

server '54.169.120.18',
  user: 'ubuntu',
  roles: %w{app web app},
  ssh_options: {
  	forward_agent: true,
  }																																	

set :stage, :production
set :branch, :testin
set :ssh_options, {:forward_agent => true}

# Setting RAILS_ENV environment variable on server
set :rails_env, :production


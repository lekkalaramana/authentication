

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

#  namespace :deploy do
#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#        within release_path do
#         execute :rake, 'cache:clear'
#        end
#     end
#   end
# end

set :application, 'authentication'
set :repo_url, 'https://github.com/lekkalaramana/authentication.git'
set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

set :deploy_to, '/var/www/authentication'
set :scm, :git
set :branch, 'master'
set :keep_releases, 5
set :format, :pretty
set :log_level, :debug
set :pty, true
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :stages, %w(production development)
set :default_stage, "development"
set :ssh_options, {:forward_agent => true}
set :user , "ubuntu"
# set :assets_prefix, "hotels"

# Force rake through bundle exec
SSHKit.config.command_map[:rake] = "bundle exec rake"
 
# Force rails through bundle exec
SSHKit.config.command_map[:rails] = "bundle exec rails"
 
set :migration_role, 'app' # Defaults to 'db'
set :assets_roles, [:app] # Defaults to [:web]
# Shared directories over different deployments
set :linked_dirs, %w(pids log)

# set :whenever_environment, ->{ fetch :rails_env, fetch(:stage, "production") }
# set :whenever_command, 'bundle exec whenever'

namespace :deploy do
 
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
    #execute "chown -R www-data:www-data /var/www/cleartripHotels"
    # execute "ln -s #{shared_path}/sitemaps/* #{release_path}/public/hotels"
    execute "sudo service apache2 restart"
        # within release_path do
        #   rake "searchkick:reindex:all"
        # end
    end
  end
  desc 'precompile assets'
  task :precompile do
    on roles(:app), in: :sequence, wait: 5 do
      with :environment=>:production do 
        within release_path do
          rake "assets:clean"
          rake "assets:precompile NG_FORCE=true"
          #rake "assets:copy"
        end
      end
    end
  end

  after :finishing, 'deploy:restart'
  # after :finishing, 'deploy:cleanup'
  after :updated, 'deploy:precompile'
end


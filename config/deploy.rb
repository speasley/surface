# config valid only for current version of Capistrano
lock "3.4.0"
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

set :application, "stronglifters"
set :repo_url, "git@github.com:stronglifters/surface.git"
set :branch, "master"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :scm is :git
# set :scm, :git
set :scm, :s3
set :bucket_name, "stronglifters"

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push(
  "config/database.yml",
  ".env.#{fetch(:rails_env, 'production')}",
)

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push(
  "log",
  "tmp/pids",
  "tmp/cache",
  "tmp/sockets",
  "vendor/bundle",
  "public/system",
)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

if File.exist?("config/deploy_id_rsa")
  set :ssh_options, keys: ["config/deploy_id_rsa"], forward_agent: true
else
  set :ssh_options, forward_agent: true
end
set :rbenv_type, :system
set :rbenv_ruby, "2.2.2"

namespace :deploy do
  task :restart do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute :service, "puma restart"
    end
  end

  after :publishing, :restart
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, "cache:clear"
      # end
    end
  end
end

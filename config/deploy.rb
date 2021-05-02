# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "by_place"
set :repo_url, "git@github.com:sameignatovich/by_place_backend.git"
set :branch, "main"
set :rails_env, "production"
set :deploy_to, "/home/nginx/www/api.by.place"

set :format, :airbrussh
set :format_options, truncate: false

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", ".bundle", "storage"
set :keep_releases, 5

set :rvm_type, :auto
set :passenger_restart_with_touch, true

namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key_file do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! 'config/master.key', "#{shared_path}/config/master.key"
        end
      end
    end
  end

  # before :finishing, :restart_sidekiq do
  #   on roles(:app) do
  #     execute "sudo systemctl restart sidekiq.service"
  #   end
  # end
end

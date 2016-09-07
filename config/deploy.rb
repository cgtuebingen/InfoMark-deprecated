# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'automark'
set :repo_url, 'git@github.com:PatWie/automark.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/automark'


# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
#set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# --------------------------------------------------
# Use SSL on port 443 to serve on https. Every request to por 80
# will be rewritten to 443
# default value: false
set :nginx_use_ssl, true

# Name of SSL certificate file
set :nginx_ssl_cert, "nginx.crt"

# Name of SSL certificate private key
#default value: "#{application}.key"
set :nginx_ssl_cert_key, "nginx.key"
# SSL certificate private key path
# default value: "/etc/ssl/private"
set :nginx_ssl_certificate_key_path, "/etc/nginx/ssl/"
# --------------------------------------------------


set :rbenv_ruby, '2.2.3'


# we put other uploads to "/data" and therefore use this relative link from /public/data --> /data
namespace :deploy do
  desc "Change data Symlink to relative path"
  task :create_symlink do
    on roles(:app) do
        execute "cd #{deploy_to}/current/public FOLDER && ln -s /data/ data"
        info "Created symlink to other harddisk \"/data\""
    end
  end
end

#lets rate uses deprecated image-path, so lets copy this manually
namespace :deploy do
  desc "copy rate stars"
  task :create_ratestars do
    on roles(:app) do
        execute "cp #{deploy_to}/current/app/assets/images/*star* #{deploy_to}/current/public/assets/"
        execute "cp #{deploy_to}/current/app/assets/images/cancel* #{deploy_to}/current/public/assets/"
        info "Created rate stars in public/assets"
    end
  end
end




after 'deploy:publishing', 'resque:restart'
after 'deploy:publishing', 'deploy:create_symlink'
after 'deploy:publishing', 'deploy:create_ratestars'

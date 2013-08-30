require "rvm/capistrano"

set :application, "bankofdad.eu"
set :scm, :git
set :repository,  "git@github.com:kh2ouija/bankofdad.git"
set :branch, "master"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :ssh_options, { :forward_agent => true }

role :web, "bankofdad.eu"
role :app, "bankofdad.eu"
role :db,  "bankofdad.eu", :primary => true

set :use_sudo, false

namespace :deploy do
  task :copy_configs do
    run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "cp #{shared_path}/config/newrelic.yml #{release_path}/config/newrelic.yml"
    run "cp #{shared_path}/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
  end
  before "deploy:assets:precompile", "deploy:copy_configs"
end

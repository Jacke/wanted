require 'bundler/capistrano'
require 'thinking_sphinx/capistrano'
## Чтобы не хранить database.yml в системе контроля версий, поместите
## dayabase.yml в shared-каталог проекта на сервере и раскомментируйте
## следующие строки.

after "deploy:update_code", :copy_database_config
 task :copy_database_config, roles => :app do
   db_config = "#{shared_path}/database.yml"
   run "cp #{db_config} #{release_path}/config/database.yml"
   system "rsync -avz public/images/system/ hosting_ilia80@#{deploy_server}:/home/#{user}/projects/#{application}/shared/system"
 end
set :shared_children, shared_children + %w{public/images/system}

load 'deploy/assets'

ssh_options[:forward_agent] = true
#default_run_options[:pty] = true 

# Имя вашего проекта в панели управления.
# Не меняйте это значение без необходимости, оно используется дальше.
set :application,     "hochuli"

# Сервер размещения проекта.
set :deploy_server,   "neon.locum.ru"

# Не включать в поставку разработческие инструменты и пакеты тестирования.
set :bundle_without,  [:development, :test]

set :user,            "hosting_ilia80"
set :login,           "ilia80"
set :use_sudo,        false
set :deploy_to,       "/home/#{user}/projects/#{application}"
set :unicorn_conf,    "/etc/unicorn/#{application}.#{login}.rb"
set :unicorn_pid,     "/var/run/unicorn/#{application}.#{login}.pid"
set :bundle_dir,      File.join(fetch(:shared_path), 'gems')
role :web,            deploy_server
role :app,            deploy_server
role :db,             deploy_server, :primary => true

# Следующие строки необходимы, т.к. ваш проект использует rvm.
set :rvm_ruby_string, "2.0.0"
set :rake,            "rvm use #{rvm_ruby_string} do bundle exec rake" 
set :bundle_cmd,      "rvm use #{rvm_ruby_string} do bundle"

set :scm,             :git
# http://locum.ru/blog/hosting/git-on-locum
set :repository,      "ssh://#{user}@#{deploy_server}/home/#{user}/git/#{application}.git"
## Если ваш репозиторий в GitHub, используйте такую конфигурацию
# set :repository,    "ssh://Jacke@github.com/Jacke/wanted.git"

## --- Ниже этого места ничего менять скорее всего не нужно ---
before 'deploy:finalize_update', 'set_current_release'
task :set_current_release, :roles => :app do
    set :current_release, latest_release
end

set :unicorn_start_cmd, "(cd #{deploy_to}/current; rvm use #{rvm_ruby_string} do bundle exec unicorn_rails -Dc #{unicorn_conf})"
# - for unicorn - #
namespace :deploy do
  desc "Start application"
  task :start, :roles => :app do
    run unicorn_start_cmd
  end

  desc "Stop application"
  task :stop, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_start_cmd}"
  end
  
  desc "Link up Sphinx's indexes."
  task :symlink_sphinx_indexes, :roles => [:app] do
    run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end

  task :activate_sphinx, :roles => [:app] do
    symlink_sphinx_indexes
    thinking_sphinx.configure
    thinking_sphinx.start
  end

  before 'deploy:update_code', 'thinking_sphinx:stop'
  after 'deploy:update_code', 'deploy:activate_sphinx'

end

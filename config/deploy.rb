require 'bundler/capistrano'

# the server where migrations are run from (we don't want to run ruby on db.mxplay.com)
set :repository, "https://build@mmeng.smithmicro.net/repos/main/analytics/trunk/analytics_portal"
set :use_sudo, false
set(:deploy_to) { "/var/www/analytics_portal/#{application}" }
set :user, "deploy"
set :deploy_via, :remote_cache
set :copy_exclude, [".svn"]
set :keep_releases, 2 # for deploy:cleanup
# when getting error "no tty present and no askpass program specified" on debian 6
default_run_options[:pty] = true

task :local do
  set :application, "analytics_local"
  set :dev1, "analytics.local"
  role :app, dev1
  role :web, dev1
  role :db, dev1, :primary => true
  set :analytics_load_balancer, "analytics.local" # used in Apache config for ServerName
  set :analytics_sudo_user, "cloud"
  set :analytics_port, 80
  set :analytics_site_template, "_template.conf"
end

task :portaldev do
  set :application, "portal_dev"
  set :dev1, "dev1.analytics.smithmicro.net"
  # set :dev2, "dev2.analytics.smithmicro.net"
  role :app, dev1
  role :web, dev1
  role :db, dev1, :primary => true
  set :analytics_load_balancer, "dev.analytics.smithmicro.net" # used in Apache config for ServerName
  set :analytics_sudo_user, "cftuser"
  set :analytics_port, 90
  set :analytics_site_template, "_template.conf"
end

after "deploy", "deploy:cleanup"

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  [  # capistrano task, description, rake task to execute
      [:seed, 'Seed Data', 'db:seed'],
      [:sample_data, 'Sample Data', 'app:sample_data'],
      [:demo_users, 'Demo Users Data', 'app:demo_users'],
  ].each do |row|
    desc row[1]
    task row[0], :roles => :app do
      run "cd #{current_release} && bundle exec rake #{row[2]} RAILS_ENV=production"
    end
  end

end

namespace :apache do
  desc "update apache per-app conf files, uploading local copies"
  task :update, :roles => :app do
    local_repo_config_path = "config/sites/apache2/sites-available/#{application}.conf"
    local_repo_template_path = "config/sites/apache2/sites-available/#{analytics_site_template}"
    remote_repo_config_folder = "#{deploy_to}/current/config/sites/apache2/sites-available"
    remote_repo_config_path = "#{remote_repo_config_folder}/#{application}.conf"

    logger.info "generating from template"
    result = process_template(local_repo_template_path)
    run "mkdir -p #{remote_repo_config_folder}"
    put(result, remote_repo_config_path, :via => :scp, :mode => 0644)   

    with_user(analytics_sudo_user) do
      run "#{sudo} rm -rf /etc/apache2/sites-enabled/#{application}.conf"
      run "#{sudo} cp #{remote_repo_config_path} /etc/apache2/sites-available/#{application}.conf"
      run "#{sudo} ln -s ../sites-available/#{application}.conf /etc/apache2/sites-enabled/#{application}.conf"
    end
  end

  %w(start stop restart).each do |action|
    desc "#{action} Apache"
    task action.to_sym, :roles => :app do
      with_user(analytics_sudo_user) do
        run "#{sudo} apache2ctl #{action}"
      end
    end
  end
end

# TODO: should take in a password or clear password
def with_user(new_user, &block)
  old_user = user
  set :user, new_user
  close_sessions
  yield
  set :user, old_user
  close_sessions
end

def close_sessions
  sessions.values.each { |session| session.close }
  sessions.clear
end

def process_template(file_path)
    f = File.new(file_path)
    template = f.read
    # escape double quotes
    template = template.gsub('"','\"')
    return eval( '"' + template + '"' )
end

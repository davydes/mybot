namespace :app do
  desc 'Stop Application'
  task :stop do
    on roles(:web) do
      sudo "systemctl stop web-apps-unicorn@#{fetch :application}"
      sudo "systemctl stop web-apps-sidekiq@#{fetch :application}"
    end
  end

  desc 'Start Application'
  task :start do
    on roles(:web) do
      sudo "systemctl start web-apps-unicorn@#{fetch :application}"
      sudo "systemctl start web-apps-sidekiq@#{fetch :application}"
    end
  end

  desc 'Restart Application'
  task :restart
  before :restart, :stop
  before :restart, :start
end

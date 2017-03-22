namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:web) do
      unless `git rev-parse HEAD` == `git rev-parse origin/#{fetch :branch}`
        puts "WARNING: HEAD is not the same as origin/#{fetch :branch}"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end
  before "deploy", "deploy:check_revision"

  desc "Upload shared configs"
  task :upload do
    on roles(:web) do
      execute "mkdir -p #{shared_path}/config"
      #upload! "shared/application.#{fetch :stage}.yml", "#{shared_path}/config/application.yml"
      #upload! "shared/puma.#{fetch :stage}.rb", "#{shared_path}/config/puma.rb"
      upload! "shared/unicorn.rb", "#{shared_path}/config/unicorn.rb"
      #upload! "shared/sidekiq.yml", "#{shared_path}/config/sidekiq.yml"
    end
  end

  # after :publishing, 'app:restart'
  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end
end

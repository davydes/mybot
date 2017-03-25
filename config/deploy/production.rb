set :branch, 'feature/refactoring'
set :rails_env, 'production'
set :rake_env,  'production'
set :user, 'deploy'
ask :server, '192.168.1.102'

server fetch(:server),
       user: "#{fetch(:user)}",
       roles: %w{app db web}

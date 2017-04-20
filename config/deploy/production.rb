set :branch, 'master'
set :rails_env, 'production'
set :rake_env,  'production'
set :user, 'deploy'
set :port, 2201
set :server, 'bot.picapture.ru'

server fetch(:server),
       user: "#{fetch(:user)}",
       port: fetch(:port),
       roles: %w{app db web}

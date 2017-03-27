lock '3.7.2'

set :application, 'bot'
set :repo_url, 'git@github.com:davydes/mybot.git'
set :branch, 'master'
set :deploy_to, "/var/www/apps/#{fetch :application}"
set :scm, :git
set :format, :airbrussh
set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto
set :pty, true
set :keep_releases, 3

set :linked_files, fetch(:linked_files, []).push(
  'config/unicorn.rb',
  'config/database.yml',
  'config/secrets.yml'
)

set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/sockets'
)

set :rvm_type, :user
set :rvm_ruby_version, '2.3.1'
set :rvm_custom_path, '~/.rvm'

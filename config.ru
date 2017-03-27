require_relative 'config/environment'
require 'sidekiq/web'

run Rack::URLMap.new(
  '/' => Sinatra::Application,
  '/sidekiq' => Sidekiq::Web
)

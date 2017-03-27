require_relative 'config/environment'
require 'sidekiq/web'

run Rack::URLMap.new(
  '/' => Application,
  '/sidekiq' => Sidekiq::Web
)

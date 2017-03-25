require_relative 'boot'

require 'sinatra'
require 'sinatra/reloader' if development?
require 'telegram/bot'
require 'ostruct'
require 'json'
require_relative 'configurator'

Bundler.require(:default, :development)

require_all 'app'
require_all 'lib'

class Application < Sinatra::Base
  configure do
    set :config, Configurator.new

    enable :logging
    set :logger, config.logger

    set :bot, Telegram::Bot::Client.new(settings.config.token)
  end

  get '/' do
    'It works!'
  end

  post '/' do
    update = JSON.parse(request.body.read, object_class: OpenStruct)
    options = { bot: settings.bot, message: update.message }
    if update.message
      logger.debug "@#{update.message.from.username}: #{update.message.text}"
      MessageResponder.new(options).respond
    end
  end
end

require 'sinatra'
require 'sinatra/reloader' if development?
require 'telegram/bot'
require './lib/message_responder'
require './lib/app_configurator'
require 'ostruct'
require 'json'

class Application < Sinatra::Base
  configure do
    enable :logging

    set :config, AppConfigurator.new
    settings.config.configure

    token = settings.config.get_token
    set :bot, Telegram::Bot::Client.new(token)
  end

  get '/' do
    'It works!'
  end

  post '/' do
    update = JSON.parse(request.body.read, object_class: OpenStruc)
    options = { bot: settings.bot, message: update.message }
    if update.message
      logger.debug "@#{update.message.from.username}: #{update.message.text}"
      MessageResponder.new(options).respond
    end
  end
end

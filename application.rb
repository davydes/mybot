require 'sinatra'
require 'sinatra/reloader' if development?

require 'telegram/bot'
require './lib/message_responder'
require './lib/app_configurator'
require 'ostruct'
require 'json'

class Application < Sinatra::Base
  configure do
    set :config, AppConfigurator.new

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

require_relative 'models/init'

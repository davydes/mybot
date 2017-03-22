require 'sinatra'
require 'sinatra/reloader' if development?
require 'telegram/bot'
require './lib/message_responder'
require './lib/app_configurator'
require 'ostruct'

class Application < Sinatra::Base
  configure do
    enable :logging

    set :config, AppConfigurator.new
    settings.config.configure

    token = setting.config.get_token
    set :bot, Telegram::Bot::Client.new(token)
  end

  get '/' do
    'It works!'
  end

  post '/' do
    message = OpenStruct.new(params['message'])
    options = { bot: settings.bot, message: message }
    if message
      logger.debug "@#{message.from.username}: #{message.text}"
      MessageResponder.new(options).respond
    end
  end
end

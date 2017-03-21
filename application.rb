require 'sinatra'
require 'sinatra/reloader' if development?

class Application < Sinatra::Base
  get '/' do
    'It works!'
  end
end

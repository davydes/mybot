require 'sinatra'
require 'sinatra/reloader' if development?

class Application < Sinatra::Base
  get '/' do
    'It works!'
  end

  post '/' do
    puts JSON.parse(request.body.read)
  end
end

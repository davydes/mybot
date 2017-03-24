require 'rubygems'
require 'bundler/setup'
require 'sinatra/activerecord/rake'

Dir["#{File.dirname(__FILE__)}/lib/tasks/*.rake" ].each { |r| load r }

namespace :db do
  task :load_config do
    require './application'
  end
end

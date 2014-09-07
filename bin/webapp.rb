#!/usr/bin/env ruby
require 'sinatra'
require_relative '../lib/time_tracker.rb'
require_relative '../lib/web'

set :port, 8080
set :static, true
set :public_folder, settings.root + "/../lib/web/static"
set :views,         settings.root + "/../lib/web/views" 

enable :sessions
get '/' do
  redirect to('/time_tracker')
end

get '/time_tracker' do
  erb :index
end

get '/add_entry' do
  select = Web::CategoryInterface.new().to_select 
  current_activity = Web::ReportInterface.new().current 
  erb :add_entry, :locals => {:select => select}
end

post '/add_entry' do
  select = Web::CategoryInterface.new().to_select 
  if(params[:date] == "")
    TimeTracker::TimeEntry.new().add_entry(params[:category],params[:note])
  else
    TimeTracker::TimeEntry.new().back_entry(params[:category],params[:note],params[:date] )
  end
  erb :add_entry, :locals => {:select => select}
end

get '/categories' do
  list = Web::CategoryInterface.new().to_rows 
  erb :categories_form, :locals => {:list => list}
end

post '/categories' do
  TimeTracker::Category.new().add(params[:category] )
  list = Web::CategoryInterface.new().to_rows 
  erb :categories_form, :locals => {:list => list}
end



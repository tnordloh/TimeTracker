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
  current= Web::ReportInterface.new().current 
  erb :add_entry, :locals => {:select => select, :current => current}
end

post '/add_entry' do
  select = Web::CategoryInterface.new().to_select 
  if(params[:date] == "")
    p params
    TimeTracker::TimeEntry.new().add_entry(params[:category],params[:note])
  else
    TimeTracker::TimeEntry.new().back_entry(params[:category],params[:note],params[:date] )
  end
  current= Web::ReportInterface.new().current 
  erb :add_entry, :locals => {:select => select, :current => current}
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

get '/report' do
  erb :report_form
end

get '/report_summary' do
  report= Web::ReportInterface.new().summary()
  erb :report_data, :locals => {:report => report}
end

get '/report_last_day' do
  report= Web::ReportInterface.new().last_day()
  erb :report_data, :locals => {:report => report}
end

get '/report_current' do
  report= Web::ReportInterface.new().current()
  erb :report_data, :locals => {:report => report}
end

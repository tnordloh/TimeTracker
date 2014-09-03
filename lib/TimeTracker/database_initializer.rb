require_relative 'settings'

require 'sqlite3'

module TimeTracker
  class DatabaseInitializer
    def initialize
      @settings = TimeTracker::Settings.new('/Users/tim/code/time_tracker')
      #puts "settings:"
      #@settings.to_s
      @db = nil
    end
    def create_db
      connect
      @db.execute "CREATE TABLE IF NOT EXISTS categories(Id INTEGER PRIMARY KEY, Name TEXT)"
      @db.execute "CREATE TABLE IF NOT EXISTS time_entries(Id INTEGER PRIMARY KEY, 
                   name TEXT, 
                   starttime INTEGER, 
                   finishtime INTEGER, 
                   id_category INTEGER,
                   foreign key(id_category) references categories(Id))"
    end
    def describe table=nil
      connect
      puts @db.execute "SELECT * FROM sqlite_master"
    end
    def execute statement
      connect
      @db.execute(statement) 
    end
    def connect
      puts "#{@settings.setting(:homedir)}/data/#{@settings.setting(:database)}" if @db == nil
      @db = SQLite3::Database.new "#{@settings.setting(:homedir)}/data/#{@settings.setting(:database)}" if @db == nil
    end
  end
end
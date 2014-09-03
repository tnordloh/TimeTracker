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
    def execute2 statement
      connect
      @db.execute2(statement) 
    end
    def execute statement
      connect
      @db.execute(statement) 
    end
    def connect
      @db = SQLite3::Database.new "#{@settings.setting('homedir')}/data/#{@settings.setting('database')}" if @db == nil
    end
    def last_time_entry
      connect
      db=@db.execute("select max(id) from time_entries")
      p db
      db[0][0]
    end
  end
end

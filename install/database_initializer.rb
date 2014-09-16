require_relative '../lib/time_tracker'

require 'sqlite3'

module TimeTracker
  class DatabaseInitializer
    def initialize
      @settings = TimeTracker::Settings.new("#{File.dirname(__FILE__)}/../../")
      @db = nil
    end
    def create_db
      connect
      @db.execute "CREATE TABLE IF NOT EXISTS category(id INTEGER PRIMARY KEY, Name TEXT)"
      @db.execute "CREATE TABLE IF NOT EXISTS time_entries(id INTEGER PRIMARY KEY, 
                   name TEXT, 
                   starttime INTEGER, 
                   finishtime INTEGER, 
                   category_id INTEGER,
                   foreign key(category_id) references category(id))"
    end
  end
end

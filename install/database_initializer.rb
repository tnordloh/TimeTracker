require_relative 'settings'

require 'sqlite3'

module TimeTracker
  class DatabaseInitializer
    def initialize
      @settings = TimeTracker::Settings.new("#{File.dirname(__FILE__)}/../../")
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
  end
end

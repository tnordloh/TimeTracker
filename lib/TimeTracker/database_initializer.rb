require_relative 'settings'

require 'sqlite3'

module TimeTracker
  class DatabaseInitializer
    def initialize
      settings = TimeTracker::Settings.new()
      puts "settings:"
      settings.to_s
    end
  end
  def create_db
    db = SQLite3::Database.new "data/#{settings.setting('database')}"
    db.execute "CREATE TABLE categories(Id INTEGER PRIMARY KEY, Name TEXT)"
  end
end

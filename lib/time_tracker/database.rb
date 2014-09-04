require_relative 'settings'

require 'sqlite3'

module TimeTracker
  class Database
    def initialize
      @settings = TimeTracker::Settings.new(File.dirname(__FILE__).to_s+"/../../")
      @db = nil
    end

    def describe table=nil
      connect
      @db.execute "SELECT * FROM sqlite_master"
    end

    def execute2 statement
      connect
      @db.execute2(statement) 
    end

    def execute statement
      connect
      @db.execute(statement) 
    end
  
    def last_time_entry
      connect
      db=@db.execute("select max(id) from time_entries")
      db[0][0]
    end

    private

    def connect
      @db = SQLite3::Database.new "#{@settings.setting('homedir')}/data/#{@settings.setting('database')}" if @db == nil
    end

  end
end

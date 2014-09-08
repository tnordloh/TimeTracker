require_relative 'settings'

require 'sqlite3'

module TimeTracker
  SmartData = Struct.new :array do
    def header_names
      return array[0]
    end
    def hash
      @hash=Hash.new
      array.transpose.each {|x| @hash[x[0]] = x[1..-1] }
      @hash
    end
    def maxwidth row
      (@hash[row].map {|x| 
        x.to_s.size }
      ).max
    end
  end

  class Database
    def initialize
      @settings = TimeTracker::Settings.new(File.dirname(__FILE__)+"/../../")
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

    def execute3 statement
      connect
      to_struct @db.execute2(statement) 
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

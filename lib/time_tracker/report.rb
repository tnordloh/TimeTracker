require_relative "database_initializer"
module TimeTracker
  class Report

    def initialize
      @db= TimeTracker::Database.new()
    end

    def event whereclause = " "
      stmt ='select time_entries.id,
                     time_entries.starttime,
                     time_entries.finishtime,
                     categories.name as category,
                     time_entries.name as note
                     from time_entries
                     join categories on categories.id = time_entries.id_category ' + whereclause
      rs=@db.execute2(stmt)
      rs.inject("") { |string,row| 
        row[1]= Time.at(row[1]).strftime("%F %T") if row[1] != nil && row[1].to_i != 0
        row[2]= Time.at(row[2]).strftime("%F %T") if row[2] != nil && row[2].to_i != 0
        string += (row.map {|r| r.to_s.ljust(19)}).join("|")+ "\n"
      }
    end
    def current
      starttime = (Time.now - 86400).to_i
      event "where time_entries.id in (select max(id) from time_entries)"
    end
    def last_day
      starttime = (Time.now - 86400).to_i
      event "where time_entries.starttime > #{starttime}"
    end
    def summary time = 24
      categories = @db.execute("select distinct(time_entries.id_category),categories.name from time_entries
                               join categories on categories.id = time_entries.id_category")
      categories.inject("") { |string,row|
        minutes,seconds = (sum_category(row[0],24)).divmod(60)
        string+=  "#{row[1].to_s.ljust(15)}: #{minutes.to_s.ljust(6)} minutes, #{seconds} seconds\n" 
      }
    end
    def sum_category category,time
      times = @db.execute("select (finishtime-starttime) from time_entries where id_category=#{category} and finishtime is not null")
      times.inject(0) { |sum,row| sum+= row[0]}
    end
  end
end

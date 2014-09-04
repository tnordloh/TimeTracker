require_relative "database_initializer"
module TimeTracker
  class Report

    def initialize
      @db= TimeTracker::Database.new()
    end

    def current
      event "where time_entries.id in (select max(id) from time_entries)"
    end

    def last_day
      starttime = (Time.now - 86400).to_i
      event "where time_entries.starttime > #{starttime}"
    end

    def summary time = 24
      categories = @db.execute('select distinct(time_entries.id_category),categories.name from '+
                               'time_entries join categories on categories.id = time_entries.id_category') 
      format_summary categories
    end


    private

    def event whereclause = " "
      stmt ='select time_entries.id,
                     time_entries.starttime,
                     time_entries.finishtime,
                     categories.name as category,
                     time_entries.name as note
                     from time_entries
                     join categories on categories.id = time_entries.id_category ' + whereclause
      format_table @db.execute2(stmt)
    end

    def format_summary categories
      categories.inject("") { |string,row|
        mytime = convert_seconds_to_hours_minutes_seconds(sum_category(row[0],24))
        string+=  "#{row[1].to_s.ljust(10)}: #{mytime[0].to_s.rjust(2)} hours, #{mytime[1].to_s.rjust(2)} minutes, #{mytime[2]} seconds\n" 
      }
    end

    def format_table data
      widths=colsizes(data)
      widths[1],widths[2] = 19,19
      data.inject("") { |string,row| 
        x=-1
        row[1]=unix_to_standard row[1]
        row[2]=unix_to_standard row[2]
        string += (row.map {|r|
                  x+=1
                  r.to_s.ljust(widths[x]+2)
                                }).join("|")+ "\n"
      }
    end
    def colsizes data
      list=[]
      data.transpose.each {|col| list << (col.max {|a,b| a.to_s().length <=> b.to_s().length()}).to_s.length}
      list
    end
    def sum_category category,time
      times = @db.execute("select (finishtime-starttime) from time_entries where id_category=#{category} and finishtime is not null")
      times.inject(0) { |sum,row| sum+= row[0]}
    end

    def unix_to_standard time
        time= Time.at(time).strftime("%F %T") if time != nil && time.to_i != 0
    end

    def convert_seconds_to_hours_minutes_seconds number
        hours = number / (60*60)
        minutes,seconds =number.divmod(60)
        minutes -= hours*60
        return [hours,minutes,seconds]
    end
  end
end

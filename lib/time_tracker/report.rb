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
      summary_to_a categories
    end

    def unix_to_standard time
        time= Time.at(time).strftime("%F %T") if time != nil && time.to_i != 0
    end

    private
    def sum_category category,time
      times = @db.execute("select (finishtime-starttime) from time_entries where id_category=#{category} and finishtime is not null")
      times.inject(0) { |sum,row| sum+= row[0]}
    end

    def event whereclause = " "
      @db.execute2('select time_entries.id,
                     time_entries.starttime,
                     time_entries.finishtime,
                     categories.name as category,
                     time_entries.name as note
                     from time_entries
                     join categories on categories.id = time_entries.id_category ' + whereclause)
    end

    def summary_to_a categories
      returnme = []
      categories.each { |row|
        mytime = convert_seconds_to_hours_minutes_seconds(sum_category(row[0],24))
        returnme <<  [row[1], mytime[0] , mytime[1], mytime[2] ]
      }
      returnme
    end

    def convert_seconds_to_hours_minutes_seconds number
        hours = number / (60*60)
        minutes,seconds =number.divmod(60)
        minutes -= hours*60
        return [hours,minutes,seconds]
    end
  end
end

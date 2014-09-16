require_relative "../time_tracker"
module TimeTracker
  class Report

#TODO: rename the id_category field to category_id, which will eliminate the need for coding the join as seen below.
    JOIN="join category on category.id = time_entries.category_id"
    def current
      DB::Time_entries.find(DB::Time_entries.maximum(:id))
    end

    def last_day
      starttime = (Time.now - 86400).to_i
#TODO: rename the id_category field to category_id, which will eliminate the need for coding the join as seen below.
      DB::Time_entries.joins(JOIN).where("time_entries.starttime> #{starttime}").map 
    end

    def summary time = 24
#TODO: rename the id_category field to category_id, which will eliminate the need for coding the join as seen below.
      summary_to_a DB::Time_entries.select("distinct(time_entries.category_id),category.name").joins(JOIN).map {|x|
        x.category_id
      }
    end

    def unix_to_standard time
        if time != nil && time.to_i != 0
          return Time.at(time).strftime("%F %T")
        end
        return ""
    end

    private
    def sum_category category,time
      x= DB::Time_entries.where(category_id: category  ).where.not(finishtime: nil)
      x.inject(0) { |sum,row| sum+ row.finishtime.to_i - row.starttime.to_i  }
    end

    def summary_to_a cats
      cats.map { |category| 
        mytime = convert_seconds_to_hours_minutes_seconds(sum_category(category,24))
        [DB::Category.find(category).name, mytime[0] , mytime[1], mytime[2] ]
      }
    end

    def convert_seconds_to_hours_minutes_seconds number
        hours = number / (60*60)
        minutes,seconds =number.divmod(60)
        minutes -= hours*60
        return [hours,minutes,seconds]
    end

  end
end

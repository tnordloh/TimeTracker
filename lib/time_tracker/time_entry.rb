require_relative 'category'
require 'time'

module TimeTracker
  class TimeEntry

    def add_entry category,description,time=nil
      time = Time.now.to_i if time == nil
      insert_time_entry DB::Categories.find_by(Name: category).Id, description, time
    end

    def back_entry category,description,time
      time=Time.parse(time).to_i
      fail_if_entry_later_than_latest(time)
      add_entry category,description,time
    end
  
    private
    def fail_if_entry_later_than_latest time
      raise "time entry failed.  Last entry was greater than or equal to new entry #{time}" if time <= DB::Time_entries.maximum(:finishtime)
    end
    def compose_add_entry_error category
      catlist = TimeTracker::Category.new().list.each.inject([]) {|list,category| list << category}
      raise "tnordloh:no category #{category} found: valid categories are #{catlist}" if rs.size == 0
    end
#TODO: shorten this function, and add data verification functionality.  Or move to a real database, that build proper constraints there.
    def insert_time_entry cat_id, description ,time=nil
      entry = DB::Time_entries.find_by(finishtime: nil)
      entry.finishtime=time
      entry.save 
      DB::Time_entries.create(id_category: cat_id, name: description, starttime: time)
    end

  end
end

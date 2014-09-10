require_relative 'category'
require 'time'

module TimeTracker
  class TimeEntry
    def initialize
    end

    def add_entry category,description,time=nil
      puts "add_entry:values(#{category},'#{description}',#{time})"
      insert_time_entry DB::Categories.find_by(Name: category).Id, description, time
    end

    def back_entry category,description, time
      puts "add_entry:values(#{category},'#{description}',#{time})"
      x=DB::Time_entries.maximum(:finishtime)
      t=Time.parse(time).to_i
      if t > x
        add_entry category,description, Time.parse(time).to_i 
      else
        raise "time entry failed.  Last entry #{x} was greater than or equal to new entry #{t}"
      end
    end

    private

    def compose_add_entry_error category
      catlist = TimeTracker::Category.new().list.each.inject([]) {|list,category| list << category}
      raise "tnordloh:no category #{category} found: valid categories are #{catlist}" if rs.size == 0
    end

    def insert_time_entry cat_id, description ,time=nil
      time=Time.now.to_i if time==nil
      entry = DB::Time_entries.find_by(finishtime: nil)
      entry.finishtime=time
      puts "values(#{cat_id},'#{description}',#{time})"
      entry.save if DB::Time_entries.create(id_category: cat_id, name: description, starttime: time)
    end

  end
end

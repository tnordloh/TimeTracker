require_relative 'database'
require_relative 'category'
require 'time'

module TimeTracker
  class TimeEntry
    def initialize
      @db= TimeTracker::Database.new()
    end

    def add_entry category,description,time=nil
      puts "add_entry:values(#{category},'#{description}',#{time})"
      rs = @db.execute("select id from categories where name='#{category}'")
      compose_add_entry_error if rs.size == 0
      insert_time_entry rs[0][0], description, time
    end

    def back_entry category,description, time
      puts "add_entry:values(#{category},'#{description}',#{time})"
      x=@db.execute "select max(finishtime) from time_entries"
      t=Time.parse(time).to_i
      if t > x[0][0]
        add_entry category,description, Time.parse(time).to_i 
      else
        raise "time entry failed.  Last entry #{x[0][0]} was greater than or equal to new entry #{t}"
      end
    end

    private

    def compose_add_entry_error category
      catlist = TimeTracker::Category.new().list.each.inject([]) {|list,category| list << category}
      raise "tnordloh:no category #{category} found: valid categories are #{catlist}" if rs.size == 0
    end

    def insert_time_entry cat_id, description ,time=nil
      time=Time.now.to_i if time==nil
      @db.execute "update time_entries set finishtime=#{time} where id=#{@db.last_time_entry}"
      puts "values(#{cat_id},'#{description}',#{time})"
      @db.execute "insert into time_entries (id_category,name,starttime) values(#{cat_id},'#{description}',#{time})"
    end

  end
end

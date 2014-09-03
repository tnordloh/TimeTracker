require_relative 'database'
require_relative 'category'

module TimeTracker
  class TimeEntry
    def initialize
      @db= TimeTracker::Database.new()
    end
    def add_entry category,description
      rs = @db.execute("select id from categories where name='#{category}'")
      if rs.size == 0
        catlist = TimeTracker::Category.new().list.each.inject([]) {|list,category| list << category}
        raise "tnordloh:no category #{category} found: valid categories are #{catlist}" if rs.size == 0
      end
      #puts "id equals #{rs[0][0]}"
      time=Time.now.to_i
      id = @db.last_time_entry
      puts id
      @db.execute "update time_entries set finishtime=#{time} where id=#{id}"
      @db.execute "insert into time_entries (id_category,name,starttime) values(#{rs[0][0]},'#{description}',#{time})"
    end
  end
end

require_relative 'database'
require_relative 'category'

module TimeTracker
  class TimeEntry
    def initialize
      @db= TimeTracker::Database.new()
    end

    def add_entry category,description
      rs = @db.execute("select id from categories where name='#{category}'")
      compose_add_entry_error if rs.size == 0
      insert_time_entry rs[0][0], description
    end

    def back_entry
    end

    private

    def compose_add_entry_error category
      catlist = TimeTracker::Category.new().list.each.inject([]) {|list,category| list << category}
      raise "tnordloh:no category #{category} found: valid categories are #{catlist}" if rs.size == 0
    end

    def insert_time_entry cat_id, description
      time=Time.now.to_i
      @db.execute "update time_entries set finishtime=#{time} where id=#{@db.last_time_entry}"
      @db.execute "insert into time_entries (id_category,name,starttime) values(#{cat_id},'#{description}',#{time})"
    end

  end
end

require_relative 'database'

module TimeTracker

  class Category
    def initialize
      @db= TimeTracker::Database.new()
    end
    def add category
      @db.execute "insert into categories(name) values('#{category.downcase}')"
    end
    def list
      @db.execute("select name from categories").each { |row| row.join "\s" }
    end
    def delete category
      @db.execute "delete from categories where name='#{category}'"
    end
  end

end

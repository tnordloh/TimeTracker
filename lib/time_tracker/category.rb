require_relative 'database_initializer'

module TimeTracker

  class Category
    def initialize
      @db= TimeTracker::Database.new()
    end
    def add category
      @db.execute "insert into categories(name) values('#{category.downcase}')"
    end
    def list
      rs = @db.execute "select * from categories"
      rs.each do |row|
        puts row.join "\s"
      end
    end
    def delete category
      rs = @db.execute "delete from categories where name='#{category}'"
    end
  end

end

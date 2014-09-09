require_relative 'database'

module TimeTracker
  class Category
    def add category
      DB::Categories.create(Name: category)
    end
    def list
      DB::Categories.all.map {|x| x.Name}
    end
    def delete category
      DB::Categories.find_by(Name: category).destroy
    end
  end

end

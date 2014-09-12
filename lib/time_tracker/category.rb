require_relative "../time_tracker"
module TimeTracker
  class Category

    def add category
      DB::Categories.create(Name: category)
    end

    Category = Struct.new(:id, :name)

    def list
      DB::Categories.all.collect() {|item| Category.new(item.Id,item.Name) }
    end

    def delete category
      DB::Categories.find_by(Name: category).destroy
    end

  end
end

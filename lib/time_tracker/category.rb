require_relative "../time_tracker"
module TimeTracker
  class Category

    def add category
      DB::Category.create(name: category)
    end

    Category = Struct.new(:id, :name)

    def list
      DB::Category.all.collect() {|item| Category.new(item.id,item.name) }
    end

    def delete category
      DB::Category.find_by(name: category).destroy
    end

  end
end

require_relative "../time_tracker"
module TimeTracker
  class Category
    def add category
      DB::Categories.create(Name: category)
    end
    def list
      DB::Categories.all.each_with_object({}) {|i,a| a[i.id]= i.Name }
    end
    def delete category
      DB::Categories.find_by(Name: category).destroy
    end
  end

end

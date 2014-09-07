require_relative '../time_tracker'
module Web
  class CategoryInterface <TimeTracker::Category
    def list
      super()
    end
    def to_select category = "category"
      "<select id='#{category}' name='#{category}'>\n"+ list().map {|item|
        "<option value='#{item[0]}'>#{item[0]}</option>\n"
      }.join("\n") + "</select>"
    end
    def to_rows
      list().map {|item|
        "<p>#{item[0]}</p>"
      }.join("\n")
    end
  end
end

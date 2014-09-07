require_relative '../time_tracker'
module Web
  class ReportInterface < TimeTracker::Report
    def current
      "<table><tr>" + super().inject("") {|string,row|
        string += "<tr>" + row_to_column(row)
      } + "</table>"
    end
    def row_to_column row
      "<td>"+ row.join("<td>")
    end
  end
end

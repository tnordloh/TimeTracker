require_relative '../time_tracker'
module Web
  class ReportInterface < TimeTracker::Report
    def current
      "<table border=1><tr>" + super().inject("") {|string,row|
        string += "<tr>" + row_to_column(row)
      } + "</table>"
    end
    def summary
      "<table border=1><tr><th>category<th>hours<th>minutes<th>seconds<tr>" + super().inject("") {|string,row|
        string += "<tr>" + row_to_column(row)
      } + "</table>"
    end
    def last_day
      "<table border=1><tr>" + super().inject("") {|string,row|
        string += "<tr>" + row_to_column(row)
      } + "</table>"
    end
    def row_to_column row
      "<td>"+ row.join("<td>")
    end
  end
end

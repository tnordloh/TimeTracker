require_relative '../time_tracker'
module CLI
  class Report < TimeTracker::Report
    def current
      format_table super()
    end
    def summary
      super().inject("") { |string,row|
        string+="#{row[0].to_s.ljust(10)}: #{row[1].to_s.rjust(2)} hours, #{row[2].to_s.rjust(2)} minutes, #{row[3]} seconds\n"
      }
    end
    def last_day
      format_table super()
    end
    def format_table data
      widths=colsizes(data)
      widths[1],widths[2] = 19,19
      data.inject("") { |string,row| 
        x=-1
        row[1]=unix_to_standard row[1]
        row[2]=unix_to_standard row[2]
        string += (row.map {|r|
          x+=1
          r.to_s.ljust(widths[x]+2)
        }).join("|")+ "\n"
      }
    end
    def colsizes data
      list=[]
      data.transpose.each {|col| list << (col.max {|a,b| a.to_s().length <=> b.to_s().length()}).to_s.length}
      list
    end
  end
end

require_relative '../time_tracker'
module CLI
  class Report < TimeTracker::Report

    def current 
      data= super() 
      super().attribute_names.inject("") {|string,x| string+ "#{x}:#{data.send(x)}\n"}
    end

    def summary
      super().inject("") { |string,row|
        string+"#{row[0].to_s.ljust(10)}: #{row[1].to_s.rjust(2)} hours, #{row[2].to_s.rjust(2)} minutes, #{row[3]} seconds\n"
      }
    end

    def last_day
      format_table super()
    end

#todo:  this is just dumb.  Fix.
    def format_table data
      widths=colsizes(data)
      widths["finishtime"],widths["starttime"] = 19,19
      data.inject("") { |string,r| 
        string+"#{r.id.to_s.ljust(widths["id"])}|#{r.name.ljust(widths["name"])}|#{unix_to_standard(r.starttime).ljust(19)}|#{unix_to_standard(r.finishtime).ljust(19)}|#{DB::Category.find(r.category_id).name}\n" 
      }
    end

#todo:  this is just dumb.  Fix.
    def colsizes data
      data.each_with_object(Hash.new(0)) {|row,myhash|
        row.attribute_names.each {|x| 
          length = row.send(x).to_s.length
          myhash[x] = length if myhash[x] <= length || myhash[x] == nil 
        }
      }
    end

  end
end

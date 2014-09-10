require_relative "../time_tracker"
module Cli
  class Category < TimeTracker::Category

    def list
      super().inject("") {|string,x| string+"#{x[0]}:#{x[1]}\n" }
    end

  end
end

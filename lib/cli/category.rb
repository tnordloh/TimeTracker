require_relative "../time_tracker"
module Cli
  class Category < TimeTracker::Category

    def list
      super().inject("") {|string,x| string+"#{x[:id]}:#{x[:name]}\n" }
    end

  end
end

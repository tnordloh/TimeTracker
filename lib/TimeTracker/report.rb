module TimeTracker

  class Report
    def initialize
      @db= TimeTracker::DatabaseInitializer.new()
    end
  end

end

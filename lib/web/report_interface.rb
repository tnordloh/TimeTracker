require_relative '../time_tracker'
module Web
  class ReportInterface
    def initialize
      @tr = TimeTracker::Report.new()
    end
    def current
      p @tr.current()
    end
  end
end

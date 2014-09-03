module TimeTracker

  class Settings
    attr_reader :settings

    def initialize homedir
      @settings = Hash.new()
      @homedir = homedir
      load_settings
    end

    def to_s
      @settings.each {|key,value|
        puts "#{key}, #{value}"
      }
    end

    def load_settings
      @settings[:homedir]='/Users/tim/code/time_tracker'
      @settings = eval(File.open("#{@settings[:homedir]}/conf/options") {|f| f.read.chomp })
    end
    def setting setting
      @settings[setting]
    end

  end

end

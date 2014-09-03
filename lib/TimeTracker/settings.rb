module TimeTracker

  class Settings
    attr_reader :settings

    def initialize
      @settings = Hash.new()
      load_settings
    end

    def to_s
      @settings.each {|key,value|
        puts "#{key}, #{value}"
      }
    end

    def load_settings
      @settings = eval(File.open('conf/options') {|f| f.read })
    end
    def setting setting
      @settings[setting]
    end

  end

end

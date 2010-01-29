module Downlow
  class Fetcher
    
    def self.handles(which)
      @@handlers ||= []
      @@handlers << [which, self]
    end
    
    def self.fetcher_for(url)
      @@handlers.each do |matcher, klass|
        return klass if matcher.match url
      end
    end
    
    def self.fetch(url, to_path = false)
      
    end
    
    attr_reader :url, :options, :local_path
    
    def initialize(url, options = {})
      @url     = url
      @options = options
      @tmp_dir = Pathname.new(options[:tmp_dir] || 'tmp').expand_path
    end
    
    def fetch  
      raise "Should be overridden by subclass"
    end
    
    def tmp_dir
      @tmp_dir
    end
        
  end
end
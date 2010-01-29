module Downlow
  class Extractor
    
    def self.handles(which)
      @@handlers ||= []
      @@handlers << [which, self]
    end
    
    def self.extractor_for(path)
      @@handlers.each do |matcher, klass|
        return klass if matcher.match path
      end
    end
    
    def self.extract(url, options = {})
      klass = extractor_for(url)
      extractor = klass.new(url, options)
      extractor.extract
      extractor
    end
    
    attr_reader :path, :options, :final_path, :tmp_dir, :destination
    
    def initialize(path, options = {})
      @path        = Pathname.new(path)
      @options     = options
      @tmp_dir     = Pathname.new(options[:tmp_dir] || 'tmp').expand_path
      @tmp_dir.mkpath
      @destination = Pathname.new(options[:destination] || tmp_dir + self.path.stem ).expand_path
      @destination.dirname.mkpath
    end
    
    def extract
      raise "Should be overridden by subclass"
    end
    
    def extracted?
      !!@final_path
    end
    
  end
end
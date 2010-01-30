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
    
    def self.fetch(url, options = {})
      klass = fetcher_for(url)
      fetcher = klass.new(url, options)
      fetcher.fetch
      fetcher.local_path
    end
    
    attr_reader :url, :options, :local_path
    attr_accessor :tmp_dir, :destination
    
    def initialize(url, options = {})
      @url     = Pathname.new(url)
      @options = options
      @tmp_dir = Pathname.new(options[:tmp_dir] || 'tmp').expand_path
      @tmp_dir.mkpath
      @destination = Pathname.new(options[:destination] || tmp_dir + self.url.basename ).expand_path
      @destination.dirname.mkpath
    end
    
    def fetch
      raise "Should be overridden by subclass"
    end
    
    def fetched?
      !!@local_path
    end
    
  end
end
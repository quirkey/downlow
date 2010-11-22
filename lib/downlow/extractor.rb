module Downlow
  class Extractor

    def self.handles(which, options = {})
      @@handlers ||= []
      @@handlers << [which, options, self]
    end

    def self.extractor_for(path)
      @@handlers.each do |matcher, options, klass|
        if options[:file_only] && !File.file?(path)
          next
        else
          return klass if matcher.match(path)
        end
      end
    end

    def self.extract(url, options = {})
      klass = extractor_for(url)
      extractor = klass.new(url, options)
      extractor.extract
      extractor.final_path
    end

    attr_reader :path, :options, :final_path
    attr_accessor :tmp_dir, :destination

    def initialize(path, options = {})
      @path        = Pathname.new(path)
      @options     = options
      @tmp_dir     = Pathname.new(options[:tmp_dir] || 'tmp').expand_path + 'extract'
      @tmp_dir.mkpath
      @destination = Pathname.new(options[:destination] || tmp_dir + self.path.stem).expand_path
    end

    def extract
      raise "Should be overridden by subclass"
    end

    def extracted?
      !!@final_path
    end

  end
end

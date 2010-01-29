require 'zlib'

module Downlow
  class Zip < Extractor
    
    handles(/\.zip$/)
    
    def extract
      Zip::ZipFile.foreach(path) do |file|
        path = destination + file.name
        path.dirname.mkpath
        file.extract(path)
      end
      @final_path = destination
    end
    
  end
end
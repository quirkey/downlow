module Downlow
  class Dir < Extractor
    
    handles(/.*$/)
    
    def extract
      if path.directory?
        if destination.split.last != path.basename
          self.destination = destination + path.basename
        end
        destination.mkpath
      else
        destination.dirname.mkpath
      end
      path.cp destination
      @final_path = destination
    end
    
  end
end
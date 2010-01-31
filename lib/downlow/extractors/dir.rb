module Downlow
  class Dir < Extractor
    
    handles(/.*$/)
    
    def extract
      if path.directory?
        self.destination = destination + path.basename
        destination.dirname.mkpath
      else
        destination.dirname.mkpath
      end
      path.cp destination
      @final_path = destination
    end
    
  end
end
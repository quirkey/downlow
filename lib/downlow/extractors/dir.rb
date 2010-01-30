module Downlow
  class Dir < Extractor
    
    handles(/.*$/)
    
    def extract
      self.destination = destination + path.basename
      path.cp destination
      @final_path = destination
    end
    
  end
end
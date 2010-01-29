module Downlow
  class Dir < Extractor
    
    handles(/.*$/)
    
    def extract
      path.cp destination
      @final_path = destination
    end
    
  end
end
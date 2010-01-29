module Downlow
  class Local < Fetcher
    
    handles(/\w+/)
    
    def fetch
      url.cp destination
      @local_path = destination
    end
    
  end
end
    
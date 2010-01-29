require 'open-uri'

module Downlow
  class Http < Fetcher
    
    handles(/^http\:\/\//)
    
    def fetch
      f = File.open(destination, 'w')
      open(url.to_s) do |u|      
        f << u.read
      end
      f.close
      @local_path = destination
    end
    
  end
end
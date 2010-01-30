require 'open-uri'

module Downlow
  class Http < Fetcher
    
    handles(/^http\:\/\//)
    
    def fetch
      data = ""
      filename = destination.basename
      open(url.to_s) do |u|
        if disposition = u.meta['content-disposition'] and
            disposition.match(/filename=\"([^\"]+)\"/)
          filename = $1
        end
        data << u.read
      end
      self.destination = destination.dirname + filename
      File.open(destination, 'w') {|f| f << data }
      @local_path = destination
    end
    
  end
end
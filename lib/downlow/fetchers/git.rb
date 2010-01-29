module Downlow
  class Git < Fetcher
    
    handles(/^git\:\/\//)
    
    def fetch
      @destination = destination.dirname + destination.stem
      command = "`which git` clone #{url} #{destination.expand_path}"
      `#{command}`
      @local_path = destination
    end
    
  end
end
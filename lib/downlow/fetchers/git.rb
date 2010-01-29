module Downlow
  class Git < Fetcher
    
    handles(/^git\:\/\//)
    
    def fetch
      command = "`which git` clone #{url} #{destination}"
      `#{command}`
      @local_path = destination
    end
    
  end
end
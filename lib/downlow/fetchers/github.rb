module Downlow
  class Github < Http
    
    handles(/^gh\:\/\//)
    
    def fetch
      # change 
      # gh://quirkey/sammy
      # to:
      # http://github.com/quirkey/sammy/tarball/master
      project = url.to_s.gsub(/^(gh\:\/\/)/, '')
      @url = "http://github.com/#{project}/tarball/master"
      super
    end
        
  end
end
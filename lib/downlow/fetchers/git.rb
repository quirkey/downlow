module Downlow
  class Git < Fetcher
    
    handles(/^git\:\/\//)
    
    def fetch
      self.destination = destination.dirname + destination.stem
      git_clone
      rm_dot_git unless options[:keep_git]
      @local_path = destination
    end
    
    def git_clone
      system "`which git` clone #{url} #{destination.expand_path}"
    end
    
    def rm_dot_git
      FileUtils.rm_rf(destination + '.git')
    end
    
  end
end
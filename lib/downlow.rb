require 'downlow/ext/pathname'

module Downlow
  VERSION = '0.1.0'
  
  def self.get(url, options = {})
    # fetch to a temp dir
    fetch_options = options.dup
    fetch_options.delete(:destination)
    fetcher       = Fetcher.fetch(url, fetch_options)
    extractor     = Extractor.extract(fetcher.local_path, options)
    extractor.final_path
  end
  
end

require 'downlow/fetcher'
require 'downlow/fetchers/git'
require 'downlow/fetchers/http'
require 'downlow/fetchers/local'

require 'downlow/extractor'
require 'downlow/extractors/tar_gz'
require 'downlow/extractors/zip'
require 'downlow/extractors/dir'
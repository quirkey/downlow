require 'downlow/ext/pathname'

module Downlow
  VERSION = '0.1.0'
  
end

require 'downlow/fetcher'
require 'downlow/fetchers/git'
require 'downlow/fetchers/http'
require 'downlow/fetchers/local'

require 'downlow/extractor'
require 'downlow/extractors/tar_gz'
require 'downlow/extractors/zip'
require 'downlow/extractors/dir'
require 'pathname'

module Downlow
  VERSION = '0.1.0'
  
end

require 'downlow/fetcher'
require 'downlow/fetchers/git'
require 'downlow/fetchers/http'
require 'downlow/fetchers/file'
    
  
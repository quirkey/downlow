require 'downlow/ext/pathname'

module Downlow
  VERSION = '0.1.0'
  
  def self.get(url, *args)
    options = {}
    first = args.shift
    if first.is_a?(Hash)
      # hash as argument means were setting the options
      options = first
    elsif first.to_s != ''
      # string as argument means we're setting the destination
      options[:destination] = first
    end
    # merge the rest as options
    args.inject(options) {|o, arg| o = o.merge(arg) } if !args.empty?
    # fetch to a temp dir
    fetch_options = options.dup
    fetch_options.delete(:destination)
    fetcher       = Fetcher.fetch(url, fetch_options)
    extractor     = Extractor.extract(fetcher.local_path, options)
    FileUtils.rm_r(fetcher.local_path) # delete tmp path
    extractor.final_path
  end
  
end

def DL(*args) Downlow.get(*args); end

require 'downlow/fetcher'
require 'downlow/fetchers/git'
require 'downlow/fetchers/http'
require 'downlow/fetchers/local'

require 'downlow/extractor'
require 'downlow/extractors/tar_gz'
require 'downlow/extractors/zip'
require 'downlow/extractors/dir'
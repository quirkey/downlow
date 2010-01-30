require 'zlib'
require 'archive/tar/minitar'

module Downlow
  class TarGz < Extractor
    
    handles(/\.tar\.gz$/)
    
    def extract
      destination.mkpath
      tgz = ::Zlib::GzipReader.new(File.open(path, 'rb'))
      ::Archive::Tar::Minitar.unpack(tgz, destination.to_s)
      @final_path = destination
    end
    
  end
end
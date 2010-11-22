require 'zip/zip'

module Downlow
  class Zip < Extractor

    handles(/\.zip$/, :file_only => true)

    def extract
      ::Zip::ZipFile.foreach(path) do |file|
        path = destination + file.name
        path.dirname.mkpath
        file.extract(path)
      end
      @final_path = destination
    end

  end
end

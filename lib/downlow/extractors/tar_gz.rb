module Downlow
  class TarGz < Extractor
    
    handles(/\.tar\.gz$/)
    
    def extract
      Zip::ZipFile.foreach(path) do |file|
        path = destination + file.name
        path.dirname.mkpath
        file.extract(path)
      end
      @final_path = destination
    end
    
  end
end
module Downlow
  class Gz < Extractor
    
    handles(/\.gz$/)
    
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
require 'helper'

class TestDownlow < Test::Unit::TestCase
  
  context "Downlow" do
    setup do
      FileUtils.rm_rf(tmp_dir) if File.readable?(tmp_dir)
    end
    
    context ".get" do
      should "fetch a gzip then extract it" do
        url = 'http://example.org/example.tar.gz'
        FakeWeb.register_uri(:get, url, :body => fixture('test.tar.gz'))
        path = Downlow.get(url, :destination => File.join(tmp_dir, 'final'))
        assert path.is_a?(Pathname)
        assert_match(/final/, path.to_s)
        assert (path + 'test/test.jpg').readable?
      end
      
      should "assume string as second arg is destination" do
        url = 'http://example.org/example.tar.gz'
        FakeWeb.register_uri(:get, url, :body => fixture('test.tar.gz'))
        path = Downlow.get(url, File.join(tmp_dir, 'final'))
        assert path.is_a?(Pathname)
        assert_match(/final/, path.to_s)
        assert (path + 'test/test.jpg').readable?        
      end
      
    end
    
  end

end


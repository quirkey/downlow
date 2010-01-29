require 'helper'

class TestDownlowFetcher < Test::Unit::TestCase
  
  context "Downlow::Fetcher" do
    setup do
      FileUtils.rm_rf(tmp_dir) if File.readable?(tmp_dir)
    end
    
    context ".fetch" do
        
    end
    
    context ".fetcher_for" do
      
      should 'determine the fetcher by URL' do
        assert_equal Downlow::Git, Downlow::Fetcher.fetcher_for('git://github.com/quirkey/sammy.git')
        assert_equal Downlow::Http, Downlow::Fetcher.fetcher_for('http://github.com/quirkey/sammy/')
      end
          
    end
    
    context "initializing" do
      setup do
        @url = 'http://github.com/quirkey/sammy/'
        @fetcher = Downlow::Http.new(@url, {:tmp_dir => tmp_dir})
      end
      
      should "set the url" do
        assert_equal @url, @fetcher.url
      end
      
      should "set the options" do
        assert_equal tmp_dir, @fetcher.options[:tmp_dir]
      end
      
    end
    
    context "fetch" do
      
      context "git" do
        should 'clone a git repo to the temp dir' do
          
        end
        
        should "set the local path" do
          
        end
        
      end
      
      context "http" do
        should 'download the file to the temp dir' do
          
        end
        
        should "set the local path" do
          
        end
      end
      
      context "ftp" do
        should_eventually "download via ftp" do
          
        end
      end
    end
    
  end

end

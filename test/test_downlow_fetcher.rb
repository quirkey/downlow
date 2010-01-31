require 'helper'

class TestDownlowFetcher < Test::Unit::TestCase
  
  context "Downlow::Fetcher" do
    setup do
      FileUtils.rm_rf(tmp_dir) if File.readable?(tmp_dir)
      @url = 'http://github.com/quirkey/sammy/'
      FakeWeb.register_uri(:get, @url, :body => 'quirkey.com Sammy')
    end
    
    context ".fetch" do
      setup do
        @path = Downlow::Fetcher.fetch(@url, {:tmp_dir => tmp_dir})
      end
      
      should "fetch the files" do
        assert @path.is_a?(Pathname)
        assert @path.file?
        assert_match(/tmp/, @path.to_s)
        assert_match(/quirkey/, @path.read)
      end
            
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
        assert_equal @url, @fetcher.url.to_s
      end
      
      should "set the options" do
        assert_equal tmp_dir, @fetcher.options[:tmp_dir]
      end
      
    end
    
    context "fetch" do
      
      context "git" do
        setup do
          class Downlow::Git
            def git_clone 
              FileUtils.cp_r(File.join(File.dirname(__FILE__), 'fixtures', 'sammy.git'), destination)
            end
          end
          @fetcher = Downlow::Git.new('git://github.com/quirkey/sammy.git', :tmp_dir => tmp_dir)
          @path = @fetcher.fetch
        end
        
        should 'clone a git repo to the temp dir' do
          assert @path.is_a?(Pathname)
          assert @path.directory?
          assert_match(/tmp/, @path.to_s)
          assert (@path + 'lib/sammy.js').readable?
        end
        
        should "set the local path" do
          assert_equal @path, @fetcher.local_path
        end
        
      end
      
      context "http" do
        setup do
          @fetcher = Downlow::Http.new(@url, :tmp_dir => tmp_dir)
          @path = @fetcher.fetch
        end
        
        should 'download the file to the temp dir' do
          assert @path.is_a?(Pathname)
          assert @path.file?
          assert_match(/tmp/, @path.to_s)
          assert_match(/quirkey/, @path.read)
        end
        
        should "set the local path" do
          assert_equal @path, @fetcher.local_path
        end
        
        should "respect content-disposition headers" do
          gist_url = "http://gist.github.com/gists/290151/download"
          FakeWeb.register_uri(:get, gist_url, :response => fixture('gist_response'))
          @fetcher = Downlow::Http.new(gist_url, :tmp_dir => tmp_dir)
          @path = @fetcher.fetch
          assert @path.is_a?(Pathname)
          assert @path.file?
          assert_match(/\.tar\.gz$/, @path.to_s)
        end
        
        should "respect location headers" do
          url = "http://github.com/quirkey/lighthouse_stats/tarball/master"
          location_url = "http://github.com/quirkey-lighthouse_stats-e9012c9.tar.gz"
          FakeWeb.register_uri(:get, url, :response => fixture('location_response'))
          FakeWeb.register_uri(:get, location_url, :body => "BODY")
          @fetcher = Downlow::Http.new(url, :tmp_dir => tmp_dir)
          @path = @fetcher.fetch
          assert @path.is_a?(Pathname)
          assert @path.file?
          assert_match(/\.tar\.gz$/, @path.to_s)
        end
        
      end
      
      context "github" do
        
        setup do
          @url = 'gh://quirkey/sammy'
          @real_url = "http://github.com/quirkey/sammy/tarball/master"
          FakeWeb.register_uri(:get, @real_url, :response => fixture('gist_response'))
          @fetcher = Downlow::Github.new(@url, :tmp_dir => tmp_dir)
          @path = @fetcher.fetch
        end
        
        should "reset the url to the tarball url" do
          assert_equal @real_url, @fetcher.url
        end        
      end
      
      context "file" do
        setup do
          @fetcher = Downlow::Local.new(File.join(File.dirname(__FILE__), '..', 'lib'), :tmp_dir => tmp_dir)
          @path = @fetcher.fetch
        end
        
        should "move directory into temp dir" do
          assert @path.is_a?(Pathname)
          assert @path.directory?
          assert_match(/tmp/, @path.to_s)
          assert (@path + 'downlow.rb').readable?
        end
        
        should "set the local path" do
          assert_equal @path, @fetcher.local_path
        end
        
      end
      
      context "ftp" do
        should_eventually "download via ftp" do
          
        end
      end
    end
    
  end

end

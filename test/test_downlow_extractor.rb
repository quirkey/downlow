require 'helper'

class TestDownlowExtractor < Test::Unit::TestCase

  context "Downlow::Extractor" do
    setup do
      FileUtils.rm_rf(tmp_dir) if File.readable?(tmp_dir)
    end

    context ".extract" do
      setup do
        @path = fixture_path('test.zip')
        @final_path = Downlow::Extractor.extract(@path, {:destination => tmp_dir})
      end

      should "extract the files" do
        assert @final_path.is_a?(Pathname)
        assert @final_path.directory?
        assert_match(/tmp/, @final_path.to_s)
        assert File.readable?(@final_path + 'test/test.jpg')
      end

    end

    context ".extractor_for" do

      should 'determine the fetcher by path' do
        assert_equal Downlow::TarGz, Downlow::Extractor.extractor_for(fixture_path('test.tar.gz'))
        assert_equal Downlow::Zip, Downlow::Extractor.extractor_for(fixture_path('test.zip'))
      end

    end

    context "initializing" do
      setup do
        @path = fixture_path('test.zip')
        @extractor = Downlow::Zip.new(@path, {:tmp_dir => tmp_dir})
      end

      should "set the path" do
        assert_equal @path, @extractor.path.to_s
      end

      should "set the options" do
        assert_equal tmp_dir, @extractor.options[:tmp_dir]
      end

    end

    context "extract" do

      context "zip" do
        setup do
          @extractor = Downlow::Zip.new(fixture_path('test.zip'), :destination => tmp_dir)
          @path = @extractor.extract
        end

        should 'extract to the destination' do
          assert @path.is_a?(Pathname)
          assert @path.directory?
          assert_match(/tmp/, @path.to_s)
          assert (@path + 'test/test.jpg').readable?
        end

        should "set the local path" do
          assert_equal @path, @extractor.final_path
        end

      end


      context "tar.gz" do
        setup do
          @extractor = Downlow::TarGz.new(fixture_path('test.tar.gz'), :destination => tmp_dir)
          @path = @extractor.extract
        end

        should 'extract to the destination' do
          assert @path.is_a?(Pathname)
          assert @path.directory?
          assert_match(/tmp/, @path.to_s)
          assert (@path + 'test/test.jpg').readable?
        end

        should "set the final_path" do
          assert_equal @path, @extractor.final_path
        end
      end

      context "dir" do
        setup do
          @extractor = Downlow::Dir.new(fixture_path(''), :destination => tmp_dir)
          @path = @extractor.extract
        end

        should 'extract to the destination' do
          assert @path.is_a?(Pathname)
          assert @path.directory?
          assert_match(/tmp/, @path.to_s)
          assert (@path + 'test.tar.gz').readable?
        end

        should "set the final_path" do
          assert_equal @path, @extractor.final_path
        end
      end

      context "single file" do
        setup do
          @destination = File.join(tmp_dir, "sammy.js")
          @extractor = Downlow::Dir.new(fixture_path('sammy.git/lib/sammy.js'), :destination => @destination)
          @path = @extractor.extract
        end

        should 'extract to the exact destination' do
          assert @path.is_a?(Pathname)
          assert @path.file?
          assert_match(/tmp/, @path.to_s)
          assert @path.readable?
          assert_equal @destination, @path.to_s
        end

        should "set the final_path" do
          assert_equal @path, @extractor.final_path
        end
      end
    end

  end

end

require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'fakeweb'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'downlow'

class Test::Unit::TestCase

  def tmp_dir
    dir = File.join('/tmp', 'downlow')
    FileUtils.mkdir_p(dir)
    dir
  end

  def fixture_path(path)
    full_path = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', path))
  end

  def fixture(path)
    File.read(fixture_path(path))
  end

end

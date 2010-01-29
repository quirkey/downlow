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
  
end

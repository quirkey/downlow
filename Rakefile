require 'rubygems'
require 'rake'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'downlow'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "downlow"
    gem.version = Downlow::VERSION
    gem.summary = %Q{easy downloading and extracting API}
    gem.description = %Q{Downlow provides an easy way to fetch files or archives and extract them with minimal hassle.}
    gem.email = "aaron@quirkey.com"
    gem.homepage = "http://github.com/quirkey/downlow"
    gem.authors = ["Aaron Quint"]
    
    gem.add_dependency "rubyzip", ">=0.9.1"
    gem.add_dependency "archive-tar-minitar", ">=0.5.2"
    
    gem.add_development_dependency "shoulda", ">= 0"
    gem.add_development_dependency "fakeweb", ">= 1.2"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "downlow #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

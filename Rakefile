require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
$LOAD_PATH << './lib'
require 'igp'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
    gem.name = "igp"
    gem.version = Igp::VERSION
    gem.homepage = "http://github.com/tardate/igp"
    gem.license = "MIT"
    gem.summary = %Q{It goes PING!}
    gem.description = %Q{command line interface for running longitudinal monitoring for various protocols: HTTP, HTTPS, ICMP and more}
    gem.email = "gallagher.paul@gmail.com"
    gem.authors = ["Paul Gallagher"]
    # Include your dependencies below. Runtime dependencies are required when using your gem,
    # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
    #  gem.add_runtime_dependency 'jabber4r', '> 0.1'
    #  gem.add_development_dependency 'rspec', '> 1.2.3'
  end
  Jeweler::RubygemsDotOrgTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end


require 'rspec'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["-c", "-f progress"]
  t.pattern = 'spec/**/*_spec.rb'
end


task :default  => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "igp #{Igp::VERSION}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

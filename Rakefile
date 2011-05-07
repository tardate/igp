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
    gem.description = %Q{It goes PING! .. simple command-line server monitoring with a range of protocols: ICMP, TCP, UDP, HTTP/S, LDAP/S}
    gem.email = "gallagher.paul@gmail.com"
    gem.authors = ["Paul Gallagher"]
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

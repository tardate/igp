# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{igp}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Gallagher"]
  s.date = %q{2011-05-07}
  s.description = %q{command line interface for running longitudinal monitoring for various protocols: HTTP, HTTPS, ICMP and more}
  s.email = %q{gallagher.paul@gmail.com}
  s.executables = ["igp"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "CHANGELOG",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "bin/igp",
    "igp.gemspec",
    "init.rb",
    "lib/igp.rb",
    "lib/igp/base.rb",
    "lib/igp/shell.rb",
    "lib/igp/version.rb",
    "spec/base_spec.rb",
    "spec/shell_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/tardate/igp}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.7.2}
  s.summary = %q{It goes PING!}
  s.test_files = [
    "spec/base_spec.rb",
    "spec/shell_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<net-ping>, ["~> 1.5.0"])
      s.add_runtime_dependency(%q<getoptions>, ["~> 0.3"])
      s.add_development_dependency(%q<rspec>, ["> 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<net-ping>, ["~> 1.5.0"])
      s.add_dependency(%q<getoptions>, ["~> 0.3"])
      s.add_dependency(%q<rspec>, ["> 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<net-ping>, ["~> 1.5.0"])
    s.add_dependency(%q<getoptions>, ["~> 0.3"])
    s.add_dependency(%q<rspec>, ["> 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end


# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'igp/version'

Gem::Specification.new do |spec|
  spec.name          = 'igp'
  spec.version       = Igp::VERSION
  spec.authors       = ['Paul Gallagher']
  spec.email         = ['gallagher.paul@gmail.com']
  spec.summary       = 'It goes PING!'
  spec.description   = 'Simple command-line server monitoring with a range of protocols: ICMP, TCP, UDP, HTTP/S, LDAP/S'
  spec.homepage      = 'https://github.com/tardate/igp'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'getoptions', '~> 0.3'
  spec.add_runtime_dependency 'net-ldap', '~> 0.16.0'
  spec.add_runtime_dependency 'net-ping', '~> 2.0.8'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'fakeldap', '~> 0.1.1'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rb-fsevent'
  spec.add_development_dependency 'rdoc'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'ruby-ldapserver', '~> 0.5.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end

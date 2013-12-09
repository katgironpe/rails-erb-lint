# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','rails-erb-lint','version.rb'])
Gem::Specification.new do |s|
  s.name = 'rails-erb-lint'
  s.version = RailsErbLint::VERSION
  s.author = 'Katherine Pe'
  s.email = 'k@kat.pe'
  s.homepage = 'http://c.kat.pe'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Checks validity of ERB files for your Rails app.'
  s.description = 'Lint tool for Rails ERB views'
  s.license     = 'MIT'
  s.files = Dir['lib/**/*.rb']
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'rails-erb-lint'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_dependency('actionpack', '4.0.1')
  s.add_development_dependency('builder')
  s.add_runtime_dependency('gli','2.8.1')
end

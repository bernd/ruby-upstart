# -*- encoding: utf-8 -*-
require File.expand_path('../lib/upstart/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'upstart'
  gem.version       = Upstart::VERSION
  gem.description   = %q{Library to inspect and control the Ubuntu Upstart daemon.}
  gem.summary       = %q{Library to inspect and control the Ubuntu Upstart daemon.}
  gem.homepage      = ''
  gem.authors       = ['Bernd Ahlers']
  gem.email         = ['bernd@tuneafish.de']

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'yard'
  gem.add_runtime_dependency 'ruby-dbus', '>= 0.7.2'
end

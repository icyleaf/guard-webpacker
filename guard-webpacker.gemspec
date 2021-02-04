# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/webpacker/version'

Gem::Specification.new do |spec|
  spec.name          = 'guard-webpacker'
  spec.version       = Guard::WebpackerVersion::VERSION
  spec.authors       = ['icyleaf']
  spec.email         = ['icyleaf.cn@gmail.com']

  spec.summary       = 'Guard for rails-webpacker'
  spec.description   = 'guard-webpacker automatically runs webpack-dev-server or webpack'
  spec.homepage      = 'https://github.com/icyleaf/guard-webpacker'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.3'

  spec.add_dependency 'guard', '>= 2'
  spec.add_dependency 'guard-compat', '~> 1.0'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

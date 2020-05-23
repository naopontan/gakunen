# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gakunen/version'

Gem::Specification.new do |spec|
  spec.name          = "gakunen"
  spec.version       = Gakunen::VERSION
  spec.authors       = ["nao taka"]
  spec.email         = ["naopontan@gmail.com"]

  spec.summary       = '学年を求める'
  spec.description   = '学年を求める'
  spec.homepage      = "https://github.com/naopontan/gakunen"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.13"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
end

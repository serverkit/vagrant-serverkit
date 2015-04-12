lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "vagrant/serverkit/version"

Gem::Specification.new do |spec|
  spec.name          = "vagrant-serverkit"
  spec.version       = Vagrant::Serverkit::VERSION
  spec.authors       = ["Ryo Nakamura"]
  spec.email         = ["r7kamura@gmail.com"]
  spec.summary       = "Vagrant plug-in for Serverkit."
  spec.homepage      = "https://github.com/r7kamura/vagrant-serverkit"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "serverkit", ">= 0.2.9"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
end

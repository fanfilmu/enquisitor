
# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "enquisitor/version"

Gem::Specification.new do |spec|
  spec.name          = "enquisitor"
  spec.version       = Enquisitor::VERSION
  spec.authors       = ["Michał Begejowicz"]
  spec.email         = ["michal.begejowicz@codesthq.com"]

  spec.summary       = "Easy to use but powerful searching with Elasticsearch"
  spec.description   = "Easy to use but powerful searching with Elasticsearch"
  spec.homepage      = "https://github.com/fanfilmu/enquisitor"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "elasticsearch", ">= 5.0.4"
  spec.add_dependency "typhoeus", "~> 1.3"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "pry", "~> 0.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.52"
  spec.add_development_dependency "simplecov", "~> 0.15"
end

# frozen_string_literal: true

Kernel.load "./lib/engines/logger-version.rb"

Gem::Specification.new do |s|
  s.name = "engines-logger"
  s.version = Engines::Logger::VERSION
  s.date = Time.now.strftime("%Y-%m-%d")
  s.summary = "Optinionated logging wrapper for Engines"
  s.email = "rgh@engines.org"
  s.homepage = "http://github.com/engines/engines-logger"
  s.description = "Wrapper around the logging gem with sensible defaults and configuraton via environment variables"
  s.required_ruby_version = ">= 2.7.0"

  s.author = "Engines"
  s.licenses = ["MIT"]

  s.metadata = {
    "bug_tracker_uri"   => "#{s.homepage}/issues",
    "changelog_uri"     => "#{s.homepage}/blob/master/CHANGELOG.md",
    "homepage_uri"      => s.homepage,
    "source_code_uri"   => s.homepage
  }

  s.add_dependency "logging",       "~> 2.3"
  s.add_dependency "dry-inflector", "~> 0.1"

  s.files = `git ls-files -z lib`.split(/\0/)
end

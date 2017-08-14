#encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "beautydate_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "beautydate_api"
  s.version     = BeautydateApi::VERSION
  s.authors     = ["Fábio Tomio"]
  s.email       = ["fabiotomio@gmail.com"]
  s.homepage    = "https://beautydate.com.br"
  s.summary     = "Summary of BeautydateApi."
  s.description = "Description of BeautydateApi."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency 'rest-client',   '~> 2.0.0'
  s.add_dependency 'activesupport', '~> 5.0.0'

  s.add_development_dependency 'rspec', '3.6.0'
  s.add_development_dependency 'byebug'
end

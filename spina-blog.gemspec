$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spina/blog/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spina-blog"
  s.version     = Spina::Blog::VERSION
  s.authors     = ["Tom Simnett"]
  s.email       = ["tom@initforthe.com"]
  s.homepage    = "https://github.com"
  s.summary     = "Blog Engine for Spina CMS"
  s.description = "Blog Engine for Spina CMS comprising categories and posts"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_runtime_dependency 'spina', '~> 0.11', '>= 0.11.1'
  s.add_runtime_dependency 'friendly_id', '~> 5.2', '>= 5.2.1'
  s.add_runtime_dependency 'draper', '~> 3.0', '>= 3.0.0'
  s.add_runtime_dependency 'kaminari', '~> 1.0.1', '>= 1.0.1'

  s.add_development_dependency 'sqlite3', '~> 1.3.13', '>= 1.3.13'
  s.add_development_dependency 'simplecov', '~> 0'
  s.add_development_dependency 'rspec-rails', '~> 3.6.0', '>= 3.6.0'
  s.add_development_dependency "factory_girl_rails", "~> 4.0"
  s.add_development_dependency 'pry-rails', '~> 0'
  s.add_development_dependency 'rails-controller-testing', '~> 1.0.2', '>= 1.0.2'
  s.add_development_dependency 'capybara', '~> 2.4.13', '>= 2.4.13'
end

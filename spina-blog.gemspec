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

  s.add_dependency 'spina', '>= 0.11.1'
  s.add_dependency 'friendly_id', '~> 5.2.1'
  s.add_dependency 'draper', '>= 3.0.0'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'simplecov'
  s.add_development_dependency "factory_girl_rails", "~> 4.0"
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'rails-controller-testing'
end

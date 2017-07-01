module Spina
  module Blog
    class Engine < ::Rails::Engine
      isolate_namespace Spina::Blog

      initializer "register plugin" do
        ::Spina::Plugin.register do |plugin|
          plugin.name = "blog"
          plugin.namespace = 'blog'
        end
      end

      config.generators do |g|
        g.test_framework :rspec, fixture: false
        g.fixture_replacement :factory_girl, dir: 'spec/factories'
        g.assets false
        g.helper false
      end

    end
  end
end

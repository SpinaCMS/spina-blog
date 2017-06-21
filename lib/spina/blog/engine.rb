require 'friendly_id'
require 'draper'
require 'spina'

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

    end
  end
end

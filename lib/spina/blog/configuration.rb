module Spina
  module Blog
    include ActiveSupport::Configurable

    config_accessor :title, :controller, :description, :spina_icon, :plugin_type

    self.title = 'Blog'
    self.controller = 'blog'
    self.description = 'Blog posts'
    self.spina_icon = 'pencil-outline'

    self.plugin_type = 'website_resource'
  end
end

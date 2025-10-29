# frozen_string_literal: true

module Spina
  # Spina::Blog
  module Blog
    mattr_accessor :title, default: 'Blog'
    mattr_accessor :controller, default: 'blog'
    mattr_accessor :description, default: 'Blog posts'
    mattr_accessor :spina_icon, default: 'pencil-outline'
    mattr_accessor :plugin_type, default: 'website_resource'
  end
end

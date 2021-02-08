# frozen_string_literal: true

module Spina
  # Spina::Blog
  module Blog
    include ActiveSupport::Configurable

    config_accessor(:enabled_features) { [] }
    config_accessor(:post_path)        { ->(post) { spina.blog_post_path(post) if Spina::Blog.frontend_enabled? } }
    config_accessor(:hero_image_size)  { { width: 1600, height: 1200 } }
    config_accessor(:body_image_size)  { { width: 1200, height: 800 } }
    config_accessor(:with_blog_types)  { true }
    config_accessor :layout

    def self.feature_enabled?(feature)
      config.enabled_features.include?(feature)
    end

    def self.frontend_enabled?
      !Spina.config.disable_frontend_routes
    end
  end
end

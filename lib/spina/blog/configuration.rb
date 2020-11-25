# frozen_string_literal: true

module Spina
  # Spina::Blog
  module Blog
    include ActiveSupport::Configurable

    config_accessor :enabled_features, :post_path, :hero_image_size, :body_image_size

    self.enabled_features = []
    self.post_path = ->(post) { spina.blog_post_path(post) if Spina::Blog.frontend_enabled? }
    self.hero_image_size = { width: 1600, height: 1200 }
    self.body_image_size = { width: 1200, height: 800 }

    class << self
      def feature_enabled?(feature)
        config.enabled_features.include?(feature)
      end

      def frontend_enabled?
        !Spina.config.disable_frontend_routes
      end
    end
  end
end

# frozen_string_literal: true

::Spina::Blog.configure do |config|
  # Important Note
  # ==============
  # You MUST restart your server before changes to this file
  # will take effect.

  # Enabled features. All disabled by default.
  # config.enabled_features = [:author, :categories, :featured_posts]

  # Frontend post path
  # config.post_path = ->(post) { blog_post_path(post) }

  # Recommended hero image size. Use retina (2x) sizes
  # config.hero_image_size = { width: 1600, height: 1200 }

  # Recommended body image size. Use retina (2x) sizes
  # config.body_image_size = { width: 1200, height: 800 }
end

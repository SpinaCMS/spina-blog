# frozen_string_literal: true

atom_feed language: 'en-GB', url: spina.blog_category_url(@category) do |feed|
  feed.title(@category.name)
  feed.updated(@posts[0].created_at) unless @posts.empty?

  render partial: 'blog/posts/post', collection: @posts, locals: { feed: feed }
end

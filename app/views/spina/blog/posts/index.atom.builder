# frozen_string_literal: true

atom_feed language: 'en-GB', url: spina.blog_root_url do |feed|
  feed.title('Blog')
  feed.updated(@posts[0].created_at) unless @posts.empty?

  @posts.each do |post|
    feed.entry(post, published: post.published_at, url: spina.blog_post_url(post)) do |entry|
      entry.title(post.title)
      entry.content(post.content, type: 'html')

      if post.user
        entry.author do |author|
          author.name(post.user.name)
        end
      end
    end
  end
end

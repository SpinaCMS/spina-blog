feed.entry(post, published: post.published_at, url: spina.blog_post_url(post)) do |entry|
  entry.title(post.title)
  entry.content(post.content, type: 'html')

  if post.user
    entry.author do |author|
      author.name(post.user.name)
    end
  end
end
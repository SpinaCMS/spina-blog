atom_feed language: 'en-GB', url: spina.blog_root_url do |feed|
  feed.title("Blog")
  feed.updated(@posts[0].created_at) if @posts.length > 0

  @posts.each do |post|
    feed.entry(post, published: post.published_at, url: spina.blog_post_url(post)) do |entry|
      entry.title(post.title)
      entry.content(post.content, type: 'html')

      entry.author do |author|
        author.name(post.user.name)
      end if post.user
    end
  end
end

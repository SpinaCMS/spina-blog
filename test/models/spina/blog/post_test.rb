require 'test_helper'

module Spina
  class Blog::PostTest < ActiveSupport::TestCase

    test 'should not save without title or content' do
      blog = Blog::Post.new
      assert_not blog.save
    end

    test 'creates a new post with valid attributes' do
      blog = build :spina_blog_post
      assert blog.save
    end

    test 'sets the published_at attribute on save' do
      blog = create :spina_blog_post
      assert_kind_of Time, blog.published_at
    end
  end
end

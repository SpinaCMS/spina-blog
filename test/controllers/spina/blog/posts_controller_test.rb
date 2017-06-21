require 'test_helper'

module Spina
  class Blog::PostsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test 'should get index' do
      sign_in
      get admin_blog_posts_path
      assert_response :success
    end

    test 'should redirect when logged out' do
      get admin_blog_posts_path
      assert_response :redirect
    end

    test 'should get live posts' do
      sign_in
      get live_admin_blog_posts_path
      assert_response :success
    end

    test 'only live posts are shown' do
      live_posts = FactoryGirl.create_list :spina_blog_post, 3, draft: false
      draft_post = FactoryGirl.create :spina_blog_post, draft: true

      sign_in
      get live_admin_blog_posts_path
      assert_select 'tbody tr', count: 3
    end

    test 'only draft posts are shown' do
      live_posts = FactoryGirl.create_list :spina_blog_post, 3, draft: false
      draft_post = FactoryGirl.create :spina_blog_post, draft: true

      sign_in
      get draft_admin_blog_posts_path
      assert_select 'tbody tr', count: 1
    end

    test 'only future posts are shown' do
      live_posts = FactoryGirl.create_list :spina_blog_post, 3, draft: false
      draft_post = FactoryGirl.create :spina_blog_post, draft: false, published_at: Date.today + 2

      sign_in
      get future_admin_blog_posts_path
      assert_select 'tbody tr', count: 1
    end

    test 'should get new post template' do
      sign_in
      get new_admin_blog_post_path
      assert_response :success
    end

    test 'should create a post' do
      sign_in

      assert_difference 'Spina::Blog::Post.count' do
        post admin_blog_posts_path, params: { post: FactoryGirl.attributes_for(:spina_blog_post) }
      end
    end

    test 'should not create a post when invalid' do
      sign_in

      assert_no_difference 'Spina::Blog::Post.count' do
        post admin_blog_posts_path, params: { post: { content: 'foo' } }
      end
    end

    test 'should get edit post template' do
      post = FactoryGirl.create :spina_blog_post
      sign_in
      get edit_admin_blog_post_path(post.id)
      assert_response :success
    end

    test 'should update the post' do
      post = FactoryGirl.create :spina_blog_post
      sign_in
      put admin_blog_post_path(post.id), params: { post: { title: 'Barfoo' } }

      assert post.reload.title == 'Barfoo'
    end

    test 'should not update the post if invalid' do
      post = FactoryGirl.create :spina_blog_post
      sign_in
      put admin_blog_post_path(post.id), params: { post: { title: '' } }

      assert_not post.reload.title == ''
    end

    test 'should delete a post' do
      post = FactoryGirl.create :spina_blog_post
      sign_in

      assert_difference 'Spina::Blog::Post.count', -1 do
        delete admin_blog_post_path(post.id)
      end

    end

    def sign_in
      @account = Spina::Account.create name: 'My Website', preferences: { theme: 'default' }
      @user = Spina::User.create name: 'admin', email: 'admin@example.com', password: 'password', admin: true
      post '/admin/sessions', params: { email: @user.email, password: 'password' }
    end
  end
end

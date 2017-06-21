require 'test_helper'

module Spina
  class Blog::CategoriesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test 'should get index' do
      sign_in
      get admin_blog_categories_path
      assert_response :success
    end

    test 'should redirect when logged out' do
      get admin_blog_categories_path
      assert_response :redirect
    end

    test 'should get new category template' do
      sign_in
      get new_admin_blog_category_path
      assert_response :success
    end

    test 'should create a category' do
      sign_in

      assert_difference 'Spina::Blog::Category.count' do
        post admin_blog_categories_path, params: { category: FactoryGirl.attributes_for(:spina_blog_category) }
      end
    end

    test 'should not create a category when invalid' do
      sign_in

      assert_no_difference 'Spina::Blog::Category.count' do
        post admin_blog_categories_path, params: { category: { name: '' } }
      end
    end

    test 'should get edit category template' do
      category = FactoryGirl.create :spina_blog_category
      sign_in
      get edit_admin_blog_category_path(category.id)
      assert_response :success
    end

    test 'should update the category' do
      category = FactoryGirl.create :spina_blog_category
      sign_in
      put admin_blog_category_path(category.id), params: { category: { name: 'Barfoo' } }

      assert category.reload.name == 'Barfoo'
    end

    test 'should not update the category if invalid' do
      category = FactoryGirl.create :spina_blog_category
      sign_in
      put admin_blog_category_path(category.id), params: { category: { name: '' } }

      assert_not category.reload.name == ''
    end

    test 'should delete a category' do
      category = FactoryGirl.create :spina_blog_category
      sign_in

      assert_difference 'Spina::Blog::Category.count', -1 do
        delete admin_blog_category_path(category.id)
      end

    end

    def sign_in
      @account = Spina::Account.create name: 'My Website', preferences: { theme: 'default' }
      @user = Spina::User.create name: 'admin', email: 'admin@example.com', password: 'password', admin: true
      post '/admin/sessions', params: { email: @user.email, password: 'password' }
    end
  end
end

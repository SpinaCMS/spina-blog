module Spina
  class Blog::CategoriesController < ApplicationController

    before_action :set_page
    before_action :find_category
    before_action :find_posts

    def show
    end

    private

    def find_category
      @category = Spina::Blog::Category.friendly.find params[:id]
    end

    def find_posts
      @posts = @category.posts.available.live.order(published_at: :desc).page(params[:page])
    end

    def set_page
      @page = Spina::Page.find_or_create_by name: 'blog' do |page|
        page.link_url = '/blog'
        page.deletable = false
      end
    end

  end
end

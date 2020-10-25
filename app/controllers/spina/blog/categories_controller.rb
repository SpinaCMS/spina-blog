# frozen_string_literal: true

module Spina
  module Blog
    # Spina::Blog::CategoriesController
    class CategoriesController < ApplicationController
      include ::Spina::Frontend
      
      before_action :page
      before_action :category
      before_action :posts

      def show; end

      private

      def category
        @category = Spina::Blog::Category.friendly.find params[:id]
      end

      def posts
        @posts = @category.posts.available.live.order(published_at: :desc)
                          .page(params[:page])
      end

      def page
        @page = Spina::Page.find_or_create_by name: 'blog' do |page|
          page.link_url = '/blog'
          page.deletable = false
        end
      end
    end
  end
end

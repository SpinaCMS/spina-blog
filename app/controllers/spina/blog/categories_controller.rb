# frozen_string_literal: true

module Spina
  module Blog
    # Spina::Blog::CategoriesController
    class CategoriesController < ::Spina::ApplicationController
      include ::Spina::Frontend

      before_action :page
      before_action :category
      before_action :posts
      before_action :set_theme
      before_action :add_view_path

      decorates_assigned :posts

      def show
        respond_to do |format|
          format.atom { render 'blog/categories/show' }
          format.html { render 'blog/categories/show', layout: theme_layout }
        end
      end

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

      def set_theme
        @theme = current_theme.name.parameterize.underscore
      end

      def theme_layout
        "#{@theme}/#{@page.layout_template || 'application'}"
      end

      def add_view_path
        ActiveSupport::Deprecation.new('1.0', 'Blog views should be moved from "app/views/spina/blog" to "app/views/(your_theme)/blog".')
        prepend_view_path ["app/views/#{@theme}", "app/views/spina", Spina::Blog::Engine.root.join('app', 'views', 'spina')]
      end
    end
  end
end

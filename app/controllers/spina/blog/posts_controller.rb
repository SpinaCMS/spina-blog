# frozen_string_literal: true

module Spina
  module Blog
    # Spina::Blog::PostsController
    class PostsController < ::Spina::ApplicationController
      include ::Spina::Frontend

      before_action :find_posts, only: [:index]
      before_action :current_spina_user_can_view_page?
      before_action :set_theme
      before_action :add_view_path

      decorates_assigned :posts, :post

      def index
        @posts = @posts.unscope(where: :draft) if current_spina_user&.admin?

        respond_to do |format|
          format.atom
          format.html { render 'blog/posts/index', layout: theme_layout }
        end
      end

      def show
        @post = Spina::Blog::Post.friendly.find params[:id]
        render layout: theme_layout
      rescue ActiveRecord::RecordNotFound
        try_redirect
      end

      def archive
        @posts = Spina::Blog::Post.live
                                  .where(published_at: start_date..end_date)
                                  .order(published_at: :desc)
                                  .page(params[:page])

        render 'blog/posts/show', layout: theme_layout
      end

      private

      def start_date
        Time.zone.local(params[:year].to_i, (params[:month] || 1).to_i)
      end

      def end_date
        start_date.end_of_year
      end

      def set_theme
        @theme = current_theme.name.parameterize.underscore
      end

      def theme_layout
        "#{@theme}/#{@page.layout_template || 'application'}"
      end

      def page
        @page ||= Spina::Page.find_or_create_by name: 'blog' do |page|
          page.title = 'Blog'
          page.link_url = '/blog'
          page.deletable = false
        end
      end

      def find_posts
        @posts = Spina::Blog::Post.available.live.order(published_at: :desc)
                                  .page(params[:page])
      end

      def try_redirect
        rule = RewriteRule.find_by!(old_path: "/blog/posts/#{params[:id]}")
        redirect_to rule.new_path, status: :moved_permanently
      end

      def current_spina_user_can_view_page?
        raise ActiveRecord::RecordNotFound unless current_spina_user.present? || page.live?
      end

      def add_view_path
        ActiveSupport::Deprecation.warn 'Blog views should be moved from "app/views/spina/blog" to "app/views/(your_theme)/blog".'
        prepend_view_path ["app/views/#{@theme}", "app/views/spina/", Spina::Blog::Engine.root.join('app', 'views', 'spina')]
      end
    end
  end
end

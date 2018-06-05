# frozen_string_literal: true

module Spina
  module Blog
    # Spina::Blog::PostsController
    class PostsController < ::Spina::ApplicationController
      before_action :page
      before_action :posts, only: [:index]

      def index
        # if current_spina_user and current_spina_user.admin?
        #   @posts = @posts.unscope(where: :draft)
        # end

        respond_to do |format|
          format.atom
          format.html { render layout: theme_layout }
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

        render layout: theme_layout
      end

      private

      def start_date
        Time.zone.local params[:year].to_i, (params[:month].to_i || 1)
      end

      def end_date
        start_date.end_of_year
      end

      def theme_layout
        "#{current_theme.name.parameterize.underscore}/application"
      end

      def page
        @page = Spina::Page.find_or_create_by name: 'blog' do |page|
          page.title = 'Blog'
          page.link_url = '/blog'
          page.deletable = false
        end
      end

      def posts
        @posts = Spina::Blog::Post.available.live.order(published_at: :desc)
                                  .page(params[:page])
      end

      def try_redirect
        rule = RewriteRule.find_by!(old_path: "/blog/posts/#{params[:id]}")
        redirect_to rule.new_path, status: :moved_permanently
      end
    end
  end
end

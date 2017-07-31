module Spina
  class Blog::PostsController < ::Spina::ApplicationController

    before_action :set_page
    before_action :find_posts, only: [:index]

    def index
      # if current_spina_user and current_spina_user.admin?
      #   @posts = @posts.unscope(where: :draft)
      # end

      respond_to do |format|
        format.atom
        format.html { render layout: "#{current_theme.name.parameterize.underscore}/application" }
      end
    end

    def show
      @post = Spina::Blog::Post.friendly.find params[:id]
      render layout: "#{current_theme.name.parameterize.underscore}/application"
    rescue ActiveRecord::RecordNotFound
      try_redirect
    end

    def archive
      if params[:year] and params[:month]
        start = Time.new params[:year].to_i, params[:month].to_i
        finish = start.end_of_month
      elsif params[:year]
        start = Time.new params[:year].to_i
        finish = start.end_of_year
      end

      @posts = Spina::Blog::Post.live
        .where(published_at: start..finish)
        .order(published_at: :desc)
        .page(params[:page])

      render layout: "#{current_theme.name.parameterize.underscore}/application"
    end

    private

    def set_page
      @page = Spina::Page.find_or_create_by name: 'blog' do |page|
        page.title = 'Blog'
        page.link_url = '/blog'
        page.deletable = false
      end
    end

    def find_posts
      @posts = Spina::Blog::Post.available.live.order(published_at: :desc).page(params[:page])
    end

    def try_redirect
      rule = RewriteRule.find_by!(old_path: "/blog/posts/#{params[:id]}")
      redirect_to rule.new_path, status: :moved_permanently
    end
  end
end

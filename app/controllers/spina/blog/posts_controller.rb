module Spina
  class Blog::PostsController < ApplicationController

    def index
      @posts = Spina::Blog::Post.available.live.order(published_at: :desc).page(params[:page])

      if current_user and current_user.admin?
        @posts = @posts.unscope(where: :draft)
      end

      respond_to do |format|
        format.rss
        format.html
      end
    end

    def show
      @post = Spina::Blog::Post.friendly.find params[:id]
    end

    def archive
      if params[:year] and params[:month]
        start = Date.new params[:year].to_i, params[:month].to_i
        finish = start.end_of_month
      elsif params[:year]
        start = Date.new params[:year].to_i
        finish = start.end_of_year
      end

      @posts = Spina::Blog::Post.live
        .where(published_at: start..finish)
        .order(published_at: :desc)
        .page(params[:page])
    end
  end
end

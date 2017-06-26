module Spina
  class Blog::CategoriesController < ApplicationController

    def show
      @category = Spina::Blog::Category.friendly.find params[:id]
      @posts = @category.posts.available.live.order(published_at: :desc).page(params[:page])
    end

  end
end

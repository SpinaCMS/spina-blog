module Spina
  module Admin
    class Blog::PostsController < AdminController
      before_action :set_breadcrumb
      before_action :set_tabs, only: [:new, :create, :edit, :update]
      before_action :set_locale

      decorates_assigned :post

      layout 'spina/admin/blog'

      def index
        @posts = Spina::Blog::Post.order(created_at: :desc)
      end

      def live
        @posts = Spina::Blog::Post.live.order(created_at: :desc)
        render :index
      end

      def draft
        @posts = Spina::Blog::Post.draft.order(created_at: :desc)
        render :index
      end

      def future
        @posts = Spina::Blog::Post.future.order(created_at: :desc)
        render :index
      end

      def new
        @post = Spina::Blog::Post.new
        add_breadcrumb I18n.t('spina.blog.posts.new')
        render layout: 'spina/admin/admin'
      end

      def create
        @post = Spina::Blog::Post.new post_params
        if @post.save
          redirect_to spina.edit_admin_blog_post_url(@post.id)
        else
          add_breadcrumb I18n.t('spina.blog.posts.new')
          render :new, layout: 'spina/admin/admin'
        end
      end

      def edit
        @post = Spina::Blog::Post.find params[:id]
        add_breadcrumb @post.title
        render layout: 'spina/admin/admin'
      end

      def update
        I18n.locale = params[:locale] || I18n.default_locale
        @post = Spina::Blog::Post.find(params[:id])
        respond_to do |format|
          if @post.update_attributes(post_params)
            add_breadcrumb @post.title
            @post.touch
            I18n.locale = I18n.default_locale
            format.html { redirect_to spina.edit_admin_blog_post_url(@post.id, params: {locale: @locale}) }
            format.js
          else
            format.html do
              render :edit, layout: 'spina/admin/admin'
            end
          end
        end
      end

      def destroy
        @post = Spina::Blog::Post.find(params[:id])
        @post.destroy
        redirect_to spina.admin_blog_posts_path
      end

      private

      def set_breadcrumb
        add_breadcrumb I18n.t('spina.blog.posts.title'), spina.admin_blog_posts_path
      end

      def set_tabs
        @tabs = %w{post_content post_configuration}
      end

      def set_locale
        @locale = params[:locale] || I18n.default_locale
      end

      def post_params
        params.require(:post).permit(:title, :slug, :excerpt,
          :content, :photo_id, :draft, :published_at, :spina_user_id, :category_id)
      end

    end
  end
end

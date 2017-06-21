module Spina
  module Admin
    class Blog::CategoriesController < AdminController
      before_action :set_breadcrumb
      before_action :set_locale

      decorates_assigned :category

      layout 'spina/admin/categories'

      def index
        @categories = Spina::Blog::Category.order(:name)
      end

      def new
        @category = Spina::Blog::Category.new
        add_breadcrumb I18n.t('spina.blog.categories.new')
        render layout: 'spina/admin/admin'
      end

      def create
        @category = Spina::Blog::Category.new category_params
        if @category.save
          redirect_to spina.edit_admin_blog_category_url(@category.id)
        else
          add_breadcrumb I18n.t('spina.blog.categories.new')
          render :new, layout: 'spina/admin/admin'
        end
      end

      def edit
        @category = Spina::Blog::Category.find params[:id]
        add_breadcrumb @category.name
        render layout: 'spina/admin/admin'
      end

      def update
        I18n.locale = params[:locale] || I18n.default_locale
        @category = Spina::Blog::Category.find(params[:id])
        respond_to do |format|
          if @category.update_attributes(category_params)
            add_breadcrumb @category.name
            @category.touch
            I18n.locale = I18n.default_locale
            format.html { redirect_to spina.edit_admin_blog_category_url(@category.id, params: {locale: @locale}) }
            format.js
          else
            format.html do
              render :edit, layout: 'spina/admin/admin'
            end
          end
        end
      end

      def destroy
        @category = Spina::Blog::Category.find(params[:id])
        @category.destroy
        redirect_to spina.admin_blog_categories_path
      end

      private

      def set_breadcrumb
        add_breadcrumb I18n.t('spina.blog.categories.name'), spina.admin_blog_categories_path
      end

      def set_locale
        @locale = params[:locale] || I18n.default_locale
      end

      def category_params
        params.require(:category).permit(:name)
      end

    end
  end
end

# frozen_string_literal: true

module Spina
  module Admin
    module Blog
      # Spina::Admin::Blog::CategoriesController
      class CategoriesController < AdminController
        before_action :category, except: %i[new create index]
        before_action :set_breadcrumb
        before_action :set_locale
        
        admin_section :blog

        decorates_assigned :category

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
            redirect_to spina.edit_admin_blog_category_url(@category.id),
                        notice: t('spina.blog.categories.saved')
          else
            add_breadcrumb I18n.t('spina.blog.categories.new')
            render :new, status: :unprocessable_entity
          end
        end

        def edit
          add_breadcrumb @category.name
          render layout: 'spina/admin/admin'
        end

        def update
          add_breadcrumb @category.name
          if @category.update(category_params)
            redirect_to spina.edit_admin_blog_category_url(
              @category.id, params: { locale: @locale }
            ), notice: t('spina.blog.categories.saved')
          else
            render :edit, status: :unprocessable_entity
          end
        end

        def destroy
          @category.destroy
          redirect_to spina.admin_blog_categories_path
        end

        private

        def set_breadcrumb
          add_breadcrumb I18n.t('spina.blog.categories.name'),
                         spina.admin_blog_categories_path
        end

        def category
          @category = Spina::Blog::Category.find params[:id]
        end

        def set_locale
          @locale = params[:locale] || I18n.default_locale
          I18n.locale = @locale
        end

        def category_params
          params.require(:category).permit(:name)
        end
      end
    end
  end
end

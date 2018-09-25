# frozen_string_literal: true

# AddCategoryIdToSpinaBlogPosts
class AddFeaturedToSpinaBlogPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :spina_blog_posts, :featured, :boolean, index: true,
                                                       default: false
  end
end

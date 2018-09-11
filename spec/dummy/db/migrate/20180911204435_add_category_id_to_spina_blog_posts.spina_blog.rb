# This migration comes from spina_blog (originally 4)
class AddCategoryIdToSpinaBlogPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :spina_blog_posts, :category, to_table: :spina_blog_categories
  end
end

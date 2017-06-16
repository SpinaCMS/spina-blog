class AddCategoryIdToSpinaBlogPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :spina_blog_posts, :category_id, :integer
    add_index :spina_blog_posts, :category_id
  end
end

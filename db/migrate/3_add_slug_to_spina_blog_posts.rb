class AddSlugToSpinaBlogPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :spina_blog_posts, :slug, :string, unique: true
    add_index :spina_blog_posts, :slug
  end
end

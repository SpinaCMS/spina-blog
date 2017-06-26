class AddSlugToSpinaBlogCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :spina_blog_categories, :slug, :string, unique: true
    add_index :spina_blog_categories, :slug
  end
end

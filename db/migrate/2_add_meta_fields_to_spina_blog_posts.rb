class AddMetaFieldsToSpinaBlogPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :spina_blog_posts, :draft, :boolean
    add_column :spina_blog_posts, :published_at, :datetime
  end
end

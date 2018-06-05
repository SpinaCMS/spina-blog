class CreateSpinaBlogPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :spina_blog_posts do |t|
      t.string :title
      t.text :excerpt
      t.text :content
      t.references :image, foreign_key: { to_table: :spina_images }
      t.boolean :draft
      t.datetime :published_at
      t.string :slug, unique: true, index: true
      t.references :user, foreign_key: { to_table: :spina_users }

      t.timestamps
    end
  end
end

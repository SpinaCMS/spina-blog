class CreateSpinaBlogPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :spina_blog_posts do |t|
      t.string :title
      t.text :excerpt
      t.text :content
      t.belongs_to :photo

      t.timestamps
    end
  end
end

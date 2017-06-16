class AddUserIdToSpinaBlogPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :spina_blog_posts, :spina_user, foreign_key: true
  end
end

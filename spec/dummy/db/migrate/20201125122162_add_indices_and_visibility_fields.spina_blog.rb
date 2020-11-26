# frozen_string_literal: true
# This migration comes from spina_blog (originally 7)

class AddIndicesAndVisibilityFields < ActiveRecord::Migration[5.2]
  def change
    change_table :spina_blog_posts, bulk: true do |t|
      t.boolean :corp, default: false, null: false, index: true
      t.boolean :back_office, default: false, null: false, index: true
      t.index :draft
      t.index :published_at
      t.index :featured
    end
  end
end

# This migration comes from spina (originally 14)
class AddJsonAttributesToSpinaPages < ActiveRecord::Migration[5.2]
  def change
    add_column :spina_pages, :json_attributes, :jsonb
  end
end

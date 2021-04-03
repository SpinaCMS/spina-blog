# This migration comes from spina (originally 15)
class AddSlugToSpinaResources < ActiveRecord::Migration[5.2]
  def change
    add_column :spina_resources, :slug, :jsonb
  end
end

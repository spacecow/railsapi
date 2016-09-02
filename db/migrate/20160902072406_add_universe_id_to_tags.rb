class AddUniverseIdToTags < ActiveRecord::Migration

  def up
    add_column :tags, :universe_id, :integer, null:false
    add_foreign_key :tags, :universes
  end

  def down
    remove_foreign_key :tags, :universes
    remove_column :tags, :universe_id
  end

end

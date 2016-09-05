class AddRestrictedUniverseIdToTags < ActiveRecord::Migration

  def up
    change_column :tags, :universe_id, :integer, null:false
    add_foreign_key :tags, :universes
  end

  def down
    remove_foreign_key :tags, :universes
    change_column :tags, :universe_id, :integer
  end

end

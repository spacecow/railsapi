class AddUniverseIdToTags < ActiveRecord::Migration

  def up
    add_column :tags, :universe_id, :integer
  end

  def down
    remove_column :tags, :universe_id
  end

end

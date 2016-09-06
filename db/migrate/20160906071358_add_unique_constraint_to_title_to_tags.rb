class AddUniqueConstraintToTitleToTags < ActiveRecord::Migration

  def up
    add_index :tags, [:title, :universe_id], unique:true
  end

  def down
    remove_index :tags, [:title, :universe_id]
  end

end

class AddUniqueConstraintToTitleToTags < ActiveRecord::Migration

  def up
    add_index :tags, :title, unique:true
  end

  def down
    remove_index :tags, :title
  end

end

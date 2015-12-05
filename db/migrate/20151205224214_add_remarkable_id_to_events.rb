class AddRemarkableIdToEvents < ActiveRecord::Migration

  def up
    add_column :events, :remarkable_id, :integer
    add_foreign_key :events, :remarkables
  end

  def down
    remove_foreign_key :events, :remarkables
    remove_column :events, :remarkable_id
  end

end

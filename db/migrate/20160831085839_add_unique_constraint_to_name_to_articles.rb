class AddUniqueConstraintToNameToArticles < ActiveRecord::Migration

  def up
    add_index :articles, [:name, :universe_id], unique:true
  end

  def down
    remove_index :articles, [:name, :universe_id]
  end

end

class RemoveArticleIdFromNotes < ActiveRecord::Migration

  def up
    remove_foreign_key :notes, :articles
    remove_column :notes, :article_id
  end

  def down
    add_column :notes, :article_id, :integer, null:false
    add_foreign_key :notes, :articles
  end

end

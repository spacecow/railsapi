class CreateArticleNotes < ActiveRecord::Migration

  def up
    create_table :article_notes do |t|
      t.integer :article_id, null:false
      t.integer :note_id, null:false
      t.timestamps null:false
    end
    add_foreign_key :article_notes, :articles
    add_foreign_key :article_notes, :notes
  end

  def down
    drop_table :article_notes
  end

end

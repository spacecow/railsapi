class CreateArticleNotes < ActiveRecord::Migration

  def up
    create_table :article_notes do |t|
      t.integer :article_id
      t.integer :note_id
      t.timestamps null:false
    end
  end

  def down
    drop_table :article_notes
  end

end

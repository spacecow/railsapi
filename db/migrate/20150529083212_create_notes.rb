class CreateNotes < ActiveRecord::Migration
  def up
    create_table :notes do |t|
      t.integer :article_id, null:false
      t.string :text, null:false
    end
    execute "ALTER TABLE notes ADD CONSTRAINT text_cannot_be_blank CHECK (char_length(text) <> 0)"
    add_foreign_key :notes, :articles
  end

  def down
    drop_table :notes
  end
end

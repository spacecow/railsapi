class CreateNotes < ActiveRecord::Migration
  def up
    create_table :notes do |t|
      t.integer :article_id, null:false
    end
    add_foreign_key :notes, :articles
  end

  def down
    drop_table :notes
  end
end

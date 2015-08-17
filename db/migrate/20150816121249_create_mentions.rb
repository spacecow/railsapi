class CreateMentions < ActiveRecord::Migration

  def up
    create_table :mentions do |t|
      t.integer :note_id, null:false
      t.string :image
    end
    add_foreign_key :mentions, :notes
  end

  def down
    drop_table :mentions
  end

end

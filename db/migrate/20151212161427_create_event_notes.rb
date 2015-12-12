class CreateEventNotes < ActiveRecord::Migration

  def up
    create_table :event_notes do |t|
      t.integer :event_id, null:false
      t.integer :note_id, null:false
      t.timestamps null:false
    end
    add_foreign_key :event_notes, :events
    add_foreign_key :event_notes, :notes
    add_index :event_notes, :note_id, unique:true
  end

  def down
    drop_table :event_notes
  end

end

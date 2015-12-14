class CreateNoteTags < ActiveRecord::Migration

  def up
    create_table :note_tags do |t|
      t.integer :note_id, null:false 
      t.integer :tag_id, null:false
    end
    add_foreign_key :note_tags, :notes
    add_foreign_key :note_tags, :tags
    add_index :note_tags, [:note_id, :tag_id], unique:true
    Tagging.all.each do |tagging|
      NoteTag.create note_id:tagging.tagable_id, tag_id:tagging.tag_id
    end
  end

  def down
    drop_table :note_tags
  end

end

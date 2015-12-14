class CreateNoteTags < ActiveRecord::Migration

  def up
    create_table :note_tags do |t|
      t.integer :note_id
      t.integer :tag_id
    end
    Tagging.all.each do |tagging|
      NoteTag.create note_id:tagging.tagable_id, tag_id:tagging.tag_id
    end
  end

  def down
    drop_table :note_tags
  end

end

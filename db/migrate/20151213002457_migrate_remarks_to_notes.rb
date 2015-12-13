class MigrateRemarksToNotes < ActiveRecord::Migration

  def up
    Remarkable.all.each do |remarkable|
      remarkable.remarks.each do |remark|
        note = Note.create text:remark.content
        EventNote.create(event_id:remarkable.event.id,note_id:note.id)
      end
    end
  end

  def down
    EventNote.all.each do |event_note|
      note = event_note.note
      event_note.delete
      note.delete
    end
  end

end

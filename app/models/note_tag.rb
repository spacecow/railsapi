class NoteTag < ActiveRecord::Base
  
  belongs_to :note
  belongs_to :tag

  def full_json
    as_json(only:[:id,:tag_id,:note_id])
  end

end

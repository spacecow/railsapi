class EventNote < ActiveRecord::Base

  belongs_to :event
  belongs_to :note

  def factory_json; as_json(only:[:id,:event_id,:note_id]) end

end

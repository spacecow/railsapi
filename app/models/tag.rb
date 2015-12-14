class Tag < ActiveRecord::Base
  has_many :note_tags 
  has_many :notes, through: :note_tags

  def factory_json; as_json(only:[:id,:title]) end
end 

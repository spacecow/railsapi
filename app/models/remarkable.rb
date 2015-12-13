class Remarkable < ActiveRecord::Base

  has_many :remarks
  has_one :event

  def full_json; as_json(only:[:id]) end

end

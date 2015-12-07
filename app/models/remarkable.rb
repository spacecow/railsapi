class Remarkable < ActiveRecord::Base

  has_many :remarks

  def full_json; as_json(only:[:id]) end

end

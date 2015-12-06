class Remark < ActiveRecord::Base

  belongs_to :remarkable

  def full_json; as_json(only:[:id,:content]) end

end

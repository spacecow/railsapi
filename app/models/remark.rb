class Remark < ActiveRecord::Base

  def full_json; as_json(only:[:id,:content]) end

end

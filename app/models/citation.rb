class Citation < ActiveRecord::Base

  belongs_to :origin, class_name:"Article"
  belongs_to :target, class_name:"Article"

  def factory_json; as_json(only:[:id,:content]) end

end

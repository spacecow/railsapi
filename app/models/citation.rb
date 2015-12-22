class Citation < ActiveRecord::Base

  def factory_json; as_json(only:[:id,:content]) end

end

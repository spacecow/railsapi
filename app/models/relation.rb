class Relation < ActiveRecord::Base
  
  belongs_to :target, class_name:"Article"
  belongs_to :origin, class_name:"Article"

end

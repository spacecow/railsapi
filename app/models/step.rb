class Step < ActiveRecord::Base

  belongs_to :parent, class_name:"Event"
  belongs_to :child, class_name:"Event"

end

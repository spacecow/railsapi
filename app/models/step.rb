class Step < ActiveRecord::Base

  #belongs_to :participant, class_name:"Article", foreign_key:"article_id"

  belongs_to :parent, class_name:"Event"
  belongs_to :child, class_name:"Event"

end

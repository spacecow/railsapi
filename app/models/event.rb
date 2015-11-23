class Event < ActiveRecord::Base

  belongs_to :universe
  belongs_to :parent, class_name:"Event"

end

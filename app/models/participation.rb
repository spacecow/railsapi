class Participation < ActiveRecord::Base
  
  belongs_to :participant, class_name:"Article", foreign_key:"article_id"
  belongs_to :event

end

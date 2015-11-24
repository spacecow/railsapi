class Event < ActiveRecord::Base

  belongs_to :universe
  belongs_to :parent, class_name:"Event"

  has_many :participations
  has_many :participants, through: :participations

end

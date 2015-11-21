class Universe < ActiveRecord::Base

  has_many :articles
  has_many :books
  has_many :events

end

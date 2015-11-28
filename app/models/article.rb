class Article < ActiveRecord::Base

  belongs_to :universe
  has_many :notes

end

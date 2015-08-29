class Note < ActiveRecord::Base
  belongs_to :article
  has_many :taggings, as: :tagable
  has_many :tags, through: :taggings
end

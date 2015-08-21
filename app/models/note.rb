class Note < ActiveRecord::Base
  belongs_to :article
  has_many :tags, as: :tagable
end

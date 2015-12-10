class Note < ActiveRecord::Base
  belongs_to :article
  has_many :taggings, as: :tagable
  has_many :tags, through: :taggings

  def full_json; as_json(only:[:id,:text]) end

end

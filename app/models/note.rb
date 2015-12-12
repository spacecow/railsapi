class Note < ActiveRecord::Base
  belongs_to :article

  has_one :noting, class_name:"ArticleNote"
  has_one :article, through: :noting

  has_many :taggings, as: :tagable
  has_many :tags, through: :taggings

  def factory_json; as_json(only:[:id,:text]) end
  def full_json; as_json(only:[:id,:text]) end

end

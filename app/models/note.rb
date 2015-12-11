class Note < ActiveRecord::Base
  belongs_to :article

  has_many :notings, class_name:"ArticleNote"
  has_many :articles, through: :notings

  has_many :taggings, as: :tagable
  has_many :tags, through: :taggings

  def factory_json; as_json(only:[:id,:text]) end
  def full_json; as_json(only:[:id,:text]) end

end

class Tag < ActiveRecord::Base
  has_many :note_tags 
  has_many :notes, through: :note_tags

  has_many :article_tags 
  has_many :articles, through: :article_tags

  def factory_json; as_json(only:[:id,:title]) end

  def article_id; Article.find_by(name:title).try(:id) end
end 

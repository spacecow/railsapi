class Tag < ActiveRecord::Base

  belongs_to :universe

  has_many :note_tags 
  has_many :notes, through: :note_tags

  has_many :article_tags 
  has_many :articles, through: :article_tags

  def factory_json; as_json(only:[:id,:title,:universe_id]) end
  def full_json; as_json( 
    only:[:id,:title],
    methods:[:article_id],
    include:{ notes:{ only:[:id, :text] }})
  end

  def article_id; Article.find_by(name:title).try(:id) end

end 

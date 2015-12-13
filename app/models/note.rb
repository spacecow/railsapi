class Note < ActiveRecord::Base

  has_one :article_note, class_name:"ArticleNote"
  has_one :article, through: :article_note

  has_one :event_note, class_name:"EventNote"
  has_one :event, through: :event_note

  has_many :taggings, as: :tagable
  has_many :tags, through: :taggings

  def factory_json; as_json(only:[:id,:text]) end
  def full_json
    as_json(only:[:id,:text], include:{article:{only:[:id,:name]}})
  end

end

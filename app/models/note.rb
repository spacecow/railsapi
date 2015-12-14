class Note < ActiveRecord::Base

  has_one :article_note
  has_one :article, through: :article_note

  has_one :event_note
  has_one :event, through: :event_note

  #has_many :taggings, as: :tagable
  #has_many :tags, through: :taggings
  has_many :taggings, class_name:"NoteTag" 
  has_many :tags, through: :taggings


  def article_id; article.try(:id) end
  def event_id; event.try(:id) end

  def factory_json; as_json(only:[:id,:text]) end
  def full_json
    as_json(
      only:[:id,:text],
      include:{
        article:{ only:[:id,:name] },
        event:{ only:[:id,:title] }})
  end

end

class Event < ActiveRecord::Base

  belongs_to :universe

  has_many :notings, class_name:"EventNote"
  has_many :notes, through: :notings

  has_many :mentions, foreign_key:"origin_id"
  has_many :targets, through: :mentions
  has_many :inverse_mentions, class_name:"Mention", foreign_key:"target_id"
  has_many :origins, through: :inverse_mentions, source: :origin

  has_many :article_mentions, foreign_key:"origin_id"

  has_many :steps, foreign_key:"child_id"
  has_many :parents, through: :steps
  has_many :inverse_steps, class_name:"Step", foreign_key:"parent_id"
  has_many :children, through: :inverse_steps, source: :child 

  has_many :participations
  has_many :participants, through: :participations

  def child_tokens= tokens
    self.child_ids = Event.ids_from_tokens(tokens) 
  end

  def self.ids_from_tokens tokens; tokens.split(",") end

  def parent_tokens= tokens
    self.parent_ids = Event.ids_from_tokens(tokens) 
  end

  def full_json
    as_json(
      only:[:id,:title],
      include:{
        parents:{ only:[:id,:title] },
        children:{ only:[:id,:title] },
        participations:{
          only:[:id],
          include:{ participant:{ only:[:id,:name,:gender] }}
        },
        mentions:{
          only:[:id],
          include:{ target:{ only:[:id,:title] }}
        },
        inverse_mentions:{
          only:[:id],
          include:{ origin:{ only:[:id,:title] }}
        },
        article_mentions:{
          only:[:id,:content],
          include:{ target:{ only:[:id,:name,:gender] }}
        },
        notes:{
          only:[:id,:text],
          include:{ tags:{ only:[:id,:title] }} }})
  end

  def factory_json; as_json(
    only:[:id,:title],
    include:{ universe:{ only:[:id,:title] }})
  end
  
  def universe_title; universe.title end

end

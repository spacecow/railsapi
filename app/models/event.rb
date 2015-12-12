class Event < ActiveRecord::Base

  belongs_to :universe
  belongs_to :remarkable

  has_many :notings, class_name:"EventNote"
  has_many :notes, through: :notings

  has_many :steps, foreign_key:"child_id"
  has_many :parents, through: :steps
  has_many :inverse_steps, class_name:"Step", foreign_key:"parent_id"
  has_many :children, through: :inverse_steps, source: :child 

  has_many :participations
  has_many :participants, through: :participations

  def child_tokens= tokens
    self.child_ids = Event.ids_from_tokens(tokens) 
  end

  def remarks; remarkable.try(:remarks) || [] end
 
  def self.ids_from_tokens tokens; tokens.split(",") end

  def parent_tokens= tokens
    self.parent_ids = Event.ids_from_tokens(tokens) 
  end

  def full_json remarks:[]
    as_json(
      only:[:id,:title],
      include:{
        parents:{ only:[:id,:title] },
        children:{ only:[:id,:title] },
        participants:{ only:[:id,:name,:gender] },
        notes:{
          only:[:id,:text],
          include:{ tags:{ only:[:id,:title] }}
        }
      }
    ).merge("remarks" => remarks.map(&:full_json)) 
  end

  def factory_json; as_json(
    only:[:id,:title],
    include:{ universe:{ only:[:id,:title] }})
  end
  
  def universe_title; universe.title end

end

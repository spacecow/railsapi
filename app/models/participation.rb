class Participation < ActiveRecord::Base
  
  belongs_to :participant, class_name:"Article", foreign_key:"article_id"
  belongs_to :event

  def factory_json; as_json(
    only:[:id],
    include:{
        event:{ only:[:id,:title] },
        participant:{ only:[:id,:name] }} )
  end

  def full_json; as_json(
    only:[:id],
    include:{
        event:{ only:[:id,:title] },
        participant:{ only:[:id,:name] }} )
  end


end

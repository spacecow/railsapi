class Mention < ActiveRecord::Base
  
  belongs_to :target, class_name:"Event"
  belongs_to :origin, class_name:"Event"

  def factory_json; as_json(
    only:[:id],
    include:{
      origin:{ only:[:id,:title] },
      target:{ only:[:id,:title] }})
  end

  def full_json; as_json(
    only:[:id],
    include:{
      origin:{ only:[:id,:title] },
      target:{ only:[:id,:title] }})
  end

end

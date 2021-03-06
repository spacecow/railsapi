class ArticleMention < ActiveRecord::Base

  belongs_to :origin, class_name:"Event"
  belongs_to :target, class_name:"Article"

  def factory_json; as_json(
    only:[:id,:content],
    include:{
      origin:{ only:[:id,:title] },
      target:{ only:[:id,:name] }})
  end

  def full_json; as_json(
    only:[:id,:content],
    include:{
      origin:{ only:[:id,:title] },
      target:{ only:[:id,:name] }})
  end

end

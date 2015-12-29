class ArticleMention < ActiveRecord::Base

  belongs_to :origin, class_name:"Article"
  belongs_to :target, class_name:"Article"

  def factory_json; as_json(
    only:[:id,:content],
    include:{
      origin:{ only:[:id,:name] },
      target:{ only:[:id,:name] }})
  end

end

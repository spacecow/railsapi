class ArticleNote < ActiveRecord::Base
  
  belongs_to :article
  belongs_to :note

  def full_json; as_json(only:[:id]) end

end

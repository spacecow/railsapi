class ArticleNote < ActiveRecord::Base
  
  belongs_to :article
  belongs_to :note

  def factory_json; as_json(only:[:id,:article_id,:note_id]) end

end

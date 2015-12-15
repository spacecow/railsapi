class ArticleTag < ActiveRecord::Base

  belongs_to :article
  belongs_to :tag

  def full_json; as_json(only:[:id,:tag_id,:article_id]) end

end

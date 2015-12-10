class ArticleNote < ActiveRecord::Base
  
  belongs_to :article
  belongs_to :note

end

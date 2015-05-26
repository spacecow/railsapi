class Article < ActiveRecord::Base

  belongs_to :universe

  def as_json options={}
    (super options).merge({type:type})
  end

end

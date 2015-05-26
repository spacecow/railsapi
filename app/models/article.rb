class Article < ActiveRecord::Base

  belongs_to :universe

  validates :type, inclusion:{in:%w(Character)}

  def as_json options={}
    (super options).merge({type:type})
  end

end

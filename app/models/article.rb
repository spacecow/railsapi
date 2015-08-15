class Article < ActiveRecord::Base

  belongs_to :universe
  has_many :notes

  def as_json options={}
    (super options).merge({type:type})
  end

end

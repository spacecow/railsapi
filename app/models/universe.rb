class Universe < ActiveRecord::Base

  has_many :articles
  has_many :books
  has_many :events
  has_many :tags

  def factory_json; as_json(only:[:id,:title]) end

end

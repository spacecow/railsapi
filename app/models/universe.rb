class Universe < ActiveRecord::Base

  has_many :articles
  has_many :books
  has_many :events

  def factory_json; as_json(only:[:id,:title]) end

end

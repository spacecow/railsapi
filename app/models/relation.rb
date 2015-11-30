class Relation < ActiveRecord::Base
  
  belongs_to :target, class_name:"Article"
  belongs_to :origin, class_name:"Article"

  def self.inverse_type s
    { "Owner"     => "Owns",
      "Counselor" => "Counsels"}[s]
  end

end

class Relation < ActiveRecord::Base
  
  belongs_to :target, class_name:"Article"
  belongs_to :origin, class_name:"Article"

  has_many :references, as: :referenceable

  def self.inverse_type s
    { "Owner"     => "Owns",
      "Husband"   => "Wife",
      "Counselor" => "Counsels"}[s]
  end

  def full_json; as_json({
    only:[:id,:type],
    include:{ references:{ only:[:id, :comment] }} })
  end

end

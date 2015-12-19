class Relation < ActiveRecord::Base
  
  belongs_to :target, class_name:"Article"
  belongs_to :origin, class_name:"Article"

  has_many :references, as: :referenceable

  def self.inverse_type s, gender='n'
    mapping = {
      "Acquaintance" => "Acquaintance",
      "Aunt"         => ["Nephew", "Niece"],
      "Advisor"      => "Advises",
      "Betrothed"    => "Betrothed",
      "Brother"      => ["Brother","Sister"],
      "Counselor"    => "Counsels",
      "Courter"      => "Courts",
      "Follower"     => "Commander",
      "Guide"        => "Guides",
      "Home"         => "Native",
      "Husband"      => "Wife",
      "King"         => "Rules",
      "Owner"        => "Owns",
      "Player"       => "Plays",
      "Practitioner" => "Follows",
      "Queen"        => "Rules",
      "RightHand"    => "Commander",
      "Sister"       => ["Brother","Sister"],
      "Swordbearer"  => "Commander",
      "Teacher"      => "Student",
      "Uncle"        => ["Nephew", "Niece"],
      "Variant"      => "Variant",
      "Warder"       => "Commander",
    }[s]
    case mapping
    when String; mapping
    when Array; mapping[{'n' => 0, 'm' => 0, 'f' => 1}[gender]]
    else nil
    end
  end

  def full_json; as_json({
    only:[:id,:type],
    include:{ 
      references:{ only:[:id, :comment] },
      origin:{ only:[:id,:name,:gender] },
      target:{ only:[:id,:name,:gender] }
    } })
  end

end

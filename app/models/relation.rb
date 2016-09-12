class Relation < ActiveRecord::Base
  
  belongs_to :target, class_name:"Article"
  belongs_to :origin, class_name:"Article"

  has_many :references, as: :referenceable

  def self.inverse_type s, gender='n'
    mapping = {
      "Acquaintance" => "Acquaintance",
      "Ancestor"     => "Descendant",
      "Aunt"         => ["Nephew", "Niece"],
      "Advisor"      => "Advises",
      "Betrothed"    => "Betrothed",
      "Brother"      => ["Brother","Sister"],
      "Boyfriend"    => ["Boyfriend","Girlfriend"],
      "Companion"    => "Companion",
      "ContractOn"   => "Contracted",
      "Counselor"    => "Counsels",
      "Courter"      => "Courts",
      "Cousin"       => "Cousin",
      "Creator"      => "Created",
      "Customer"     => "Provider",
      "Employee"     => "Employer",
      "Enemy"        => "Enemy",
      "Father"       => ["Son","Daughter"],
      "Follower"     => "Commander",
      "Friend"       => "Friend",
      "Girlfriend"   => ["Boyfriend","Girlfriend"],
      "Guide"        => "Guides",
      "Hearsay"      => "Talks about",
      "Home"         => "Native",
      "Husband"      => "Wife",
      "King"         => "Rules",
      "LocatedIn"    => "Location",
      "Killer"       => "Victim",
      "Maid"         => "Employer",
      "Member"       => "Part of",
      "Mother"       => ["Son","Daughter"],
      "NearSister"   => "Near sister",
      "Owner"        => "Owns",
      "Participant"  => "Participated in",
      "Player"       => "Plays",
      "Practitioner" => "Follows",
      "Queen"        => "Rules",
      "Resident"     => "Dwells",
      "RightHand"    => "Commander",
      "Ruler"        => "Rules",
      "Sister"       => ["Brother","Sister"],
      "Swordbearer"  => "Commander",
      "Teacher"      => "Student",
      "Uncle"        => ["Nephew", "Niece"],
      "Variant"      => "Variant",
      "Visitor"      => "Visits",
      "Warder"       => "Commander",
      "Wielder"      => "Wields",
      "Worshiper"    => "Worships",
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

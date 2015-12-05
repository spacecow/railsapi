class Relation < ActiveRecord::Base
  
  belongs_to :target, class_name:"Article"
  belongs_to :origin, class_name:"Article"

  has_many :references, as: :referenceable

  def self.inverse_type s, gender='n'
    mapping = {
      "Owner"        => "Owns",
      "Husband"      => "Wife",
      "Acquaintance" => "Acquaintance",
      "Follower"     => "Commander",
      "King"         => "Rules",
      "Sister"       => ["Brother","Sister"],
      "Brother"      => ["Brother","Sister"],
      "Queen"        => "Rules",
      "RightHand"    => "Commander",
      "Uncle"        => ["Nephew", "Niece"],
      "Aunt"         => ["Nephew", "Niece"],
      "Advisor"      => "Advises",
      "Counselor"    => "Counsels"}[s]
    case mapping
    when String; mapping
    when Array; mapping[{'n' => 0, 'm' => 0, 'f' => 1}[gender]]
    else nil
    end
  end

  def full_json; as_json({
    only:[:id,:type],
    include:{ references:{ only:[:id, :comment] }} })
  end

end

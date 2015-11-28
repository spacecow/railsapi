class Article < ActiveRecord::Base

  belongs_to :universe
  has_many :notes

  has_many :relations, foreign_key:"origin_id"
  has_many :targets, through: :relations
  has_many :inverse_relations, class_name:"Relation", foreign_key:"target_id"
  has_many :origins, through: :inverse_relations, source: :origin

  def relatives
    relations.as_json({
      only:[:type],
      include:{ target:{ only:[:id,:name] }} }) +
    inverse_relations.as_json({
      only:[:type],
      include:{ origin:{ only:[:id,:name] }} }).
    map do |e|
      Hash[e.map do |k,v|
        if k=="type"
          [k,Relation.inverse_type(v)]
        elsif k=="origin"
          ["target",v]
        else
          [k,v]
        end
      end ]
    end
  end

end

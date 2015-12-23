class Article < ActiveRecord::Base

  belongs_to :universe

  has_many :citations, foreign_key:"origin_id"
  has_many :inverse_citations, foreign_key:"target_id", class_name:"Citation"

  has_many :taggings, class_name:"ArticleTag" 
  has_many :tags, through: :taggings

  has_many :notings, class_name:"ArticleNote"
  has_many :notes, through: :notings

  has_many :relations, foreign_key:"origin_id"
  has_many :targets, through: :relations
  has_many :inverse_relations, class_name:"Relation", foreign_key:"target_id"
  has_many :origins, through: :inverse_relations, source: :origin

  has_many :participations
  has_many :events, through: :participations

  def relatives
    relations.as_json({
      only:[:id,:type],
      include:{
        references:{ only:[:id,:comment] },
        target:{ only:[:id,:name,:gender] }} }) +
    inverse_relations.as_json({
      only:[:id,:type],
      include:{
        references:{ only:[:id,:comment] },
        origin:{ only:[:id,:name,:gender] }} }).
    map do |e|
      Hash[e.map do |k,v|
        if k=="type"
          [k,Relation.inverse_type(v,e["origin"]["gender"])]
        elsif k=="origin"
          ["target",v]
        else
          [k,v]
        end
      end ]
    end
  end
  
end

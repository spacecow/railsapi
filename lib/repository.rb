class Repository

  #TODO show methods withot the id: param
  def article id; Article.find(id) end
  def article_as_json article
    article.as_json({
      only:[:id,:name,:type,:universe_id,:gender],
      include:{ 
        tags:{ only:[:id,:title], methods: :article_id },
        citations:{ 
          only:[:id,:content],
          include:{ target:{ only:[:id,:name,:gender] }}
        },
        inverse_citations:{ 
          only:[:id,:content],
          include:{ origin:{ only:[:id,:name,:gender] }}
        },
        notes:{
          only:[:id,:text],
          include:{ tags:{ only:[:id,:title] }}},
        events:{ only:[:id,:title] },
      }
    }).merge(article.relatives.empty? ? {} : {relatives:article.relatives})
  end
  def articles universe_id:
    Article.where(universe_id:universe_id)
  end
  def articles_as_json articles
    articles.as_json(only:[:id,:name,:type,:gender])
  end
  def create_article universe_id, params
    Universe.find(universe_id).articles.create(params)
  end
  def update_article article, params; article.update params end
  def delete_articles
    Article.destroy_all.as_json(only:[:id,:name,:type,:universe_id])
  end


  def article_mention id; ArticleMention.find(id) end
  def create_article_mention origin_id:, params:
    event(origin_id).article_mentions.create params
  end
  def update_article_mention id, params
    article_mention(id).tap{|mention| mention.update params}
  end


  def article_types
    Dir.entries("./app/models/articles").
      grep(/.*\.rb/).map{|e| e[0..-4].capitalize}
  end


  def books universe_id
    Universe.find(universe_id).books
  end
  def create_book universe_id, params
    Universe.find(universe_id).books.create params
  end
  def delete_books; Book.destroy_all end


  def create_citation params; Citation.create params end


  def event id; Event.find(id) end
  def event_as_json event
    event.as_json(
      only:[:id,:title],
      include:
      { parents:
        { only:[:id,:title] },
        children:
        { only:[:id,:title] },
        participants:
        { only:[:id,:name,:gender] }}) 
  end
  def events universe_id
    Universe.find(universe_id).events.as_json(only:[:id,:title]) end
  def create_event universe_id, params
    Universe.find(universe_id).events.create(params).as_json(only:[:id,:title, :parent_id])
  end
  def update_event event, params; event.update params end
  def delete_events; Event.delete_all end


  def create_mention origin_id:, params:
    event(origin_id).mentions.create params
  end


  def note id; Note.find(id) end
  def note_as_json n
    ts = n.tags.select(:id, :title).as_json
  #TODO reference type Note as well
    rs = references(referenceable_id:n.id, type:"Note").select(:id, :url, :comment).as_json 
    n.as_json(only:[:id,:text], include:{article:{only:[:id,:name]}}).
      merge(tags:ts).
      merge(references:rs)
  end
  def create_note article_id:, event_id:, params:{}
    parent = Article.find(article_id) unless article_id.blank?
    parent = Event.find(event_id) unless event_id.blank?
    parent.notes.create params
  end
  def notes article_id:
    Note.where(article_id:article_id)
  end
  def update_note note, params; note.update params end
  def delete_note id
    n = note(id)
    json = n.full_json
    n.article_note.try(:delete)
    n.event_note.try(:delete)
    n.delete
    json
  end
  def delete_notes; Note.destroy_all end

  
  def participation id; Participation.find id end
  def create_participation params; Participation.create params end
  def delete_participation id; participation(id).delete end


  def reference id:
    Reference.find(id).as_json
  end
  def create_reference params
    Reference.create! params
  end
  def update_reference id:, params:
    reference = Reference.find(id)
    reference.update params
    reference
  end
  def delete_references; Reference.destroy_all end
  def references referenceable_id:nil, type:nil
    if referenceable_id.nil?
      Reference.all
    else
      Reference.where(referenceable_id:referenceable_id, referenceable_type:type)
    end
  end


  def relation id; Relation.find(id) end
  def create_relation params; Relation.create(params) end
  def delete_relations; Relation.destroy_all end


  def relation_types
    Dir.entries("./app/models/relations").
      grep(/.*\.rb/).map{|e| e[0..-4].capitalize}
  end


  def create_step params
    Step.create(params).as_json(only:[:id, :parent_id, :child_id])
  end
  def delete_steps; Step.destroy_all.as_json(only:[:id, :parent_id, :child_id]) end


  def tag id; Tag.find(id) end
  def tags universe_id; Universe.find(universe_id).tags end
  def create_tag universe_id, params
    Universe.find(universe_id).tags.create params
  end
  def delete_tag id, tagable_id:, tagable_type:
    return unless %w(Article).include?(tagable_type)
    tagable_type.constantize.find(tagable_id).taggings.find_by(tag_id:id).delete
  end 


  def create_tagging tagable_type:, tagable_id:, params:
    unless %w(Note Article).include?(tagable_type)
      raise ActiveRecord::StatementInvalid.new(
        'enum tagable_type_enum INSERT INTO "taggings"')
    end
    tagable_type.constantize.find(tagable_id).taggings.create params
  end
  def delete_taggings; NoteTag.destroy_all end


  def universe id; Universe.find(id) end
  def universe_as_json universe
    universe.as_json(
      only:[:id,:title],
      include:{ articles:{ only:[:id,:name,:type,:gender] }}
    )
  end
  def universes; Universe.all end
  def create_universe params; Universe.create! params end
  def delete_universes; Universe.destroy_all end


end

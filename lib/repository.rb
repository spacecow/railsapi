class Repository

  #TODO show methods withot the id: param
  def article id; Article.find(id) end
  def article_as_json article
    article.as_json({
      only:[:id,:name,:type,:universe_id,:gender],
      include:{ 
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
  def delete_events; Event.delete_all end


  def note id; Note.find(id) end
  def note_as_json n
    ts = n.tags.select(:id, :title).as_json
  #TODO reference type Note as well
    rs = references(referenceable_id:n.id).select(:id, :url, :comment).as_json 
    as = n.articles.first.as_json(only:[:id,:name])
    json = n.as_json(only:[:id,:text])
    json = json.merge(article:as) if as
    json.merge(tags:ts).merge(references:rs)
  end
  def create_note article_id:, params:{}
    article = Article.find(article_id)
    article.notes.create params.merge(article_id:article.id)
  end
  def notes article_id:
    Note.where(article_id:article_id)
  end
  def update_note note, params; note.update params end
  def delete_notes; Note.destroy_all end

  
  def create_participation params
    Participation.create(params).as_json(only:[:id, :event_id, :article_id])
  end
  def delete_participations; Participation.destroy_all.as_json({
    only:[:id, :article_id, :event_id] })
  end


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
  def references referenceable_id:nil
    if referenceable_id.nil?
      Reference.all
    else
      Reference.where(referenceable_id:referenceable_id)
    end
  end


  def relation id; Relation.find(id) end
  def create_relation params; Relation.create(params) end
  def delete_relations; Relation.destroy_all end


  def relation_types
    Dir.entries("./app/models/relations").
      grep(/.*\.rb/).map{|e| e[0..-4].capitalize}
  end


  def remark id; Remark.find id end
  def create_remark params; Remark.create(params) end
  def update_remark remark, params; remark.update params end
  def delete_remarks; Remark.destroy_all end


  def delete_remarkables; Remarkable.destroy_all end


  def create_step params
    Step.create(params).as_json(only:[:id, :parent_id, :child_id])
  end
  def delete_steps; Step.destroy_all.as_json(only:[:id, :parent_id, :child_id]) end


  def tag id
    Tag.where(id:id).as_json(include:{
      notes:{
        only:[:id, :text],
      }
    }).first
  end
  def tags; Tag.all end
  def create_tag params:; Tag.create params end
  def delete_tags; Tag.destroy_all end


  def create_tagging tagable_type:, tagable_id:, params:
    unless %w(Note).include?(tagable_type)
      raise ActiveRecord::StatementInvalid.new(
        'enum tagable_type_enum INSERT INTO "taggings"')
    end
    tagable_type.constantize.find(tagable_id).taggings.create params
  end
  def delete_taggings; Tagging.destroy_all end


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

class Repository

  def article id:
    a = Article.find(id).as_json
    ns = notes(article_id:id).as_json
    a.merge(notes:ns)
  end
  def articles universe_id:
    Article.where(universe_id:universe_id).select(:id,:name,:type).to_a
  end
  def create_article universe_id, params
    Universe.find(universe_id).articles.create! params
  end
  def delete_articles; Article.destroy_all end


  def article_types
    Dir.entries("./app/models/article").
      grep(/.*\.rb/).map{|e| e[0..-4].capitalize}
  end


  def books universe_id
    Universe.find(universe_id).books
  end
  def create_book universe_id, params
    Universe.find(universe_id).books.create params
  end
  def delete_books; Book.destroy_all end


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
  def references note_id:nil
    if note_id.nil?
      Reference.all
    else
      Reference.where(note_id:note_id)
    end
  end


  def note id:
    n = Note.find(id)
    ts = Note.find(id).tags.select(:id, :title).as_json
    rs = references(note_id:id).select(:id, :url, :comment).as_json 
    n.as_json.merge(tags:ts).merge(references:rs)
  end
  def create_note article_id:, params:{}
    article = Article.find(article_id)
    article.notes.create params
  end
  def notes article_id:
    Note.where(article_id:article_id).select(:id, :text)
  end
  def delete_notes; Note.destroy_all end

  def create_tag params:
    #unless %w(Note).include?(tagable_type)
    #  raise ActiveRecord::StatementInvalid.new(
    #    'enum tagable_type_enum INSERT INTO "tags"')
    #end
    #tagable_type.constantize.find(tagable_id).tags.create params
    Tag.create params
  end
  def delete_tags; Tag.destroy_all end

  def create_tagging tagable_type:, tagable_id:, params:
    tagable_type.constantize.find(tagable_id).taggings.create params
  end

  def universe id
    u = Universe.find(id).as_json
    as = articles(universe_id:id).as_json
    u.merge(articles:as)
  end
  def universes; Universe.all end
  def create_universe params; Universe.create! params end
  def delete_universes; Universe.destroy_all end


end

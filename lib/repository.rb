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


  def create_note article_id:
    article = Article.find(article_id)
    Note.create article_id:article_id
  end
  def notes article_id:
    Note.where(article_id:article_id).select(:id)
  end
  def delete_notes; Note.destroy_all end

  def universe id
    u = Universe.find(id).as_json
    as = articles(universe_id:id).as_json
    u.merge(articles:as)
  end
  def universes; Universe.all end
  def create_universe params; Universe.create! params end
  def delete_universes; Universe.destroy_all end


end

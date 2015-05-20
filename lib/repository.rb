class Repository
  
  def articles; Article.all end
  def create_article universe_id, params
    Universe.find(universe_id).articles.create params
  end

  def universes; Universe.all end
  def create_universe params; Universe.create params end
  def delete_universes; Universe.destroy_all end

end

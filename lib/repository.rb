class Repository
  
  def create_article params; Article.create params end

  def universes; Universe.all end
  def create_universe params; Universe.create params end
  def delete_universes; Universe.destroy_all end

end

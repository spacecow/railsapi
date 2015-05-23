module Repo
  module ArticleRepository

    def articles universe_id
      Article.where(universe_id:universe_id).all
    end
    def create_article universe_id, params
      Universe.find(universe_id).articles.create params
    end
    def delete_articles; Article.destroy_all end

  end
end

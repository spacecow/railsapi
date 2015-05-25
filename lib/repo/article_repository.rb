module Repo
  module ArticleRepository

    def create_article universe_id, params
      Universe.find(universe_id).articles.create params
    end

    def delete_articles; Article.destroy_all end

  end
end

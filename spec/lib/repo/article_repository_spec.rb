require 'model_helper'
require './app/models/article'
require './app/models/universe'
require './lib/repo/article_repository'
require 'rspec/its'

class Dummy
  include Repo::ArticleRepository
end

describe Repo::ArticleRepository do

  let(:repository){ Dummy.new }

  describe "#articles" do
    let(:universe_id){ article.universe_id }
    let(:article){ create :article }

    before{ article }

    subject{ repository.articles(universe_id).to_a }

    context "article belongs to specified universe" do
      its(:count){ is_expected.to be 1 }
    end

    context "article does not belongs to specified universe" do
      let(:universe_id){ -1 }
      its(:count){ is_expected.to be 0 }
    end
  end

  after do
    Article.delete_all
    Universe.delete_all
  end

end

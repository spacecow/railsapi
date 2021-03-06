require 'model_helper'
require './app/models/article'
require './app/models/article_note'
require './app/models/articles/character'
require './app/models/note'
require './app/models/universe'
require './lib/repository'

describe "Repository old" do

  let(:repo){ Repository.new }
  let(:article){ create :article }
  let(:article_id){ article.id }

  describe "#article" do
    let(:function){ repo.article article_id.to_s }

    context "valid article" do
      it{ expect{function}.not_to raise_error }
    end

    context "invalid article" do
      let(:article_id){ -1 }
      it{ expect{function}.to raise_error{|e|
        expect(e).to be_a ActiveRecord::RecordNotFound
        expect(e.message).to eq "Couldn't find Article with 'id'=-1"
      } }
    end

  end

  after do
    ArticleNote.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

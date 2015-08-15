require 'model_helper'
require './app/models/article'
require './app/models/article/character'
require './app/models/note'
require './app/models/universe'
require './lib/repository'

describe Repository do

  let(:repo){ Repository.new }

  describe "#article" do
    let(:function){ repo.article id:article_id }

    let(:article){ create :article }
    let(:article_id){ article.id }

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

    context "article does not exist"

    after do
      Note.delete_all
      Article.delete_all
      Universe.delete_all
    end

  end

  describe "#create_note" do
    let(:article){ create :article }
    let(:article_id){ article.id }
    let(:universe_id){ universe.id }
    let(:universe){ article.universe }
    let(:function){ repo.create_note universe_id:universe_id.to_s, article_id:article_id.to_s }

    context "valid note" do
      it{ expect{function}.to change(Note,:count).from(0).to(1) } 
    end

    context "article is wrong" do
      let(:article_id){ -1 }
      it "cannot find the article" do
        expect{ function }.to raise_error{|e|
          expect(e).to be_a ActiveRecord::RecordNotFound
          expect(e.message).to eq "Couldn't find Article with 'id'=-1"
        }
      end
    end

    context "universe is wrong" do
      let(:universe_id){ -1 }
      it "cannot find the universe" do
        expect{ function }.to raise_error{|e|
          expect(e).to be_a ActiveRecord::RecordNotFound
          expect(e.message).to eq "Couldn't find Article with 'universe_id'=-1"
        }
      end
    end

    after do
      Note.delete_all
      Article.delete_all
      Universe.delete_all
    end
  end

end

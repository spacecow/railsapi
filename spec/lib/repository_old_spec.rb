require 'model_helper'
require './app/models/article'
require './app/models/articles/character'
require './app/models/note'
require './app/models/universe'
require './lib/repository'

describe Repository do

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

  describe "#create_note" do
    let(:params){{ text:'a note' }}
    let(:function){ repo.create_note(
      article_id:article_id.to_s, params:params )} 

    context "valid note" do
      it{ expect{function}.to change(Note,:count).from(0).to(1) } 
    end

    context "article does not exist" do
      let(:article_id){ -1 }
      it{ expect{ function }.to raise_error{|e|
          expect(e).to be_a ActiveRecord::RecordNotFound
          expect(e.message).to eq "Couldn't find Article with 'id'=-1"
        } }
    end
  end

  after do
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

require 'model_helper'
require './app/models/article'
require './app/models/note'
require './app/models/universe'

describe Note do

  let(:article){ create :article }
  let(:article_id){ article.id }
  let(:params){{ article_id:article_id, text:'a note' }}
  let(:model){ Note.create params }

  context "note is valid" do
    it{ expect{model}.to change(Note,:count).from(0).to(1) }
  end

  context "text is missing" do
    let(:params){{ article_id:article_id }}
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  context "article_id is nil" do
    let(:article_id){ nil }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  context "article_id is blank" do
    let(:article_id){ "" }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  context "article_id is set to a non-existing article" do
    let(:article_id){ -1 }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  after do
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

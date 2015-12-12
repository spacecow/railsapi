require 'model_helper'
require './app/models/article'
require './app/models/note'
require './app/models/universe'

describe "Note DB, Validations" do

  let(:text){ 'a note' }
  let(:params){{ text:text }}
  let(:model){ Note.create params }

  context "note is valid" do
    it{ expect{model}.to change(Note,:count).from(0).to(1) }
  end

  context "text is missing" do
    let(:params){{}}
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  context "text is blank" do
    let(:text){ '' }
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

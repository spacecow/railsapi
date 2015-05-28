require './spec/model_helper'
require './app/models/universe'

describe Universe do

  let(:title){ 'Malazan' }
  let(:model){ Universe.create title:title } 

  it{ expect{model}.to change(Universe,:count).from(0).to(1) }

  context "title is nil" do
    let(:title){ nil }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  context "title is blank" do
    let(:title){ "" }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  context "title is duplicated" do
    before{ Universe.create title:title }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::RecordNotUnique
    }} 
  end

  after{ Universe.delete_all }

end

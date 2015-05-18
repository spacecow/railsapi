require './spec/model_helper'
require './app/models/article'

describe Article do

  let(:name){ 'Kelsier' }
  let(:model){ Article.create name:name } 

  it{ expect{model}.to change(Article,:count).from(0).to(1) }

  context "name is not set" do
    let(:name){ nil }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  after{ Article.delete_all }

end

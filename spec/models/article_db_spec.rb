require 'rails_helper'

describe Article do

  let(:article){ create :article }

  subject{ article.send function }

  describe "#relatives" do
    let(:function){ :relatives }
    let(:swordswoman){ create :article, name:"Swordswoman" }
    let(:swordsman){ create :article, name:"Swordsman" }
    let(:owner2){ create :relation, origin:article, target:swordswoman }
    let(:owner){ create :relation, origin:article, target:swordsman }
    let(:owns){ create :relation, origin:blade, target:article }
    let(:blade){ create :article, name:"Blade" }
    before{ owner; owner2; owns }
    it{ should eq([
    { "id" => owner.id, "type"=>"Owner", "references" => [],
      "target"=>{"id"=>swordsman.id, "name"=>"Swordsman"}},
    { "id" => owner2.id, "type"=>"Owner", "references" => [],
      "target"=>{"id"=>swordswoman.id, "name"=>"Swordswoman"}},
    { "id" => owns.id, "type"=>"Owns", "references" => [],
      "target"=>{"id"=>blade.id, "name"=>"Blade"}}])}
    after{ Relation.delete_all }
  end

  after do
    Article.delete_all
    Universe.delete_all
  end

end

describe Article do

  let(:name){ 'Kelsier' }
  let(:type){ 'Character' }
  let(:universe){ create :universe }
  let(:universe_id){ universe.id }
  let(:model){ Article.create name:name, type:type, universe_id:universe_id } 

  it{ expect{model}.to change(Article,:count).from(0).to(1) }

  context "name is blank" do
    let(:name){ "" }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  context "name is nil" do
    let(:name){ nil }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  context "universe_id is not set" do
    let(:universe_id){ nil }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  context "universe_id is set to a non existing universe" do
    let(:universe_id){ -1 }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  context "type is not set" do
    let(:type){ nil }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  context "type is set to something unacceptable" do
    let(:type){ "Batman" }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::SubclassNotFound
    }} 
  end

  after do
    Article.delete_all
    Universe.delete_all
  end

end

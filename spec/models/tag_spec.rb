require 'model_helper'
require './app/models/tag'

describe Tag do

  let(:tagable_id){ 1 }
  let(:tagable_type){ "Note" }
  let(:title){ "TDP" }
  let(:params){{ tagable_id:tagable_id,
                 tagable_type:tagable_type,
                 title:title }}
  let(:model){ Tag.create params }

  context "tag is valid" do
    it{ expect{model}.to change(Tag,:count).from(0).to(1) }
  end

  context "tagable_id is nil" do
    let(:tagable_id){ nil }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  pending "tagable_id is set to a non-existing note"
  pending "tagable_id is set to a non-existing article"

  context "tagable_type is set to something else then Article or Note" do
    let(:tagable_type){ "Apa" }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid 
      expect(e.message).to include "PG::InvalidTextRepresentation" 
    }} 
  end

  context "tagable_type is nil" do
    let(:tagable_type){ nil }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

  context "tagable_type is blank" do
    let(:tagable_type){ "" }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
    }} 
  end

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

  after do
    Tag.delete_all
  end

end

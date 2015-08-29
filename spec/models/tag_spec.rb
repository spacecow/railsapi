require 'model_helper'
require './app/models/tag'

describe Tag do

  let(:tagable_id){ 1 }
  let(:tagable_type){ "Note" }
  let(:title){ "TDP" }
  let(:params){{ title:title }}
  let(:model){ Tag.create params }

  context "tag is valid" do
    it{ expect{model}.to change(Tag,:count).from(0).to(1) }
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

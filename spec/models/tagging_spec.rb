require 'model_helper'
require './app/models/universe'
require './app/models/article'
require './app/models/note'
require './app/models/tag'
require './app/models/tagging'

describe Tagging do

  let(:universe){ create :universe }
  let(:tagable_type){ "Note" }
  let(:note){ create :note }
  let(:tagable_id){ note.id }
  let(:tag){ create :tag, universe_id:universe.id }
  let(:tag_id){ tag.id }
  let(:params){{ tag_id:tag_id,
                 tagable_id:tagable_id,
                 tagable_type:tagable_type }}
  let(:model){ Tagging.create params }

  context "tagging is valid" do
    it{ expect{model}.to change(Tagging,:count).from(0).to(1) }
  end

  context "tag_id is nil" do
    let(:tag_id){ nil }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
      expect(e.message).to include "PG::NotNullViolation"
    }} 
  end

  context "tag_id points to a non-existing tag" do
    let(:tag_id){ -1 }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
      expect(e.message).to include "PG::ForeignKeyViolation"
    }} 
  end

  context "tagable_id is nil" do
    let(:tagable_id){ nil }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
      expect(e.message).to include "PG::NotNullViolation"
    }} 
  end

  pending "tagable_id points to a non-existing note"
  pending "tagable_id points to a non-existing article"

  context "tagable_type is nil" do
    let(:tagable_type){ nil }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
      expect(e.message).to include "PG::NotNullViolation"
    }} 
  end

  context "tagable_type is something other then Article or Note" do
    let(:tagable_type){ "Apa" }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid 
      expect(e.message).to include "PG::InvalidTextRepresentation" 
    }} 
  end

  context "tagable_type is blank" do
    let(:tagable_type){ "" }
    it{ expect{model}.to raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
      expect(e.message).to include "PG::NotNullViolation"
    }} 
  end







  after do
    Tagging.delete_all
    Tag.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end 

end

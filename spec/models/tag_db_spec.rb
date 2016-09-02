require 'model_helper'
require './app/models/tag'
require './app/models/universe'

describe Tag do

  let(:universe){ create :universe }
  let(:universe_id){ universe.id }
  let(:title){ "TDP" }
  let(:params){{ title:title, universe_id:universe_id }}

  subject{ ->{ Tag.create params }}

  context "Tag is valid" do
    it{ should change(Tag,:count).from(0).to(1) }
  end

  context "Param title is nil" do
    let(:title){ nil }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
      expect(e.message).to include "PG::NotNullViolation"
    }} 
  end

  context "Param title is blank" do
    let(:title){ "" }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid
      expect(e.message).to include "PG::CheckViolation"
    }} 
  end

  context "Param universe_id is nil" do
    let(:universe_id){ nil }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid 
      expect(e.message).to include "PG::NotNullViolation"
    }}
  end

  context "Universe is pointing at a non-existing universe" do
    let(:universe_id){ -1 }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::InvalidForeignKey 
      expect(e.message).to include "PG::ForeignKeyViolation"
    }}
  end

  context "title is duplicated" do
    let(:tag2){ Tag.create params }
    before{ tag2 }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::RecordNotUnique
    }} 
  end

  after do
    Tag.delete_all
    Universe.delete_all
  end

end

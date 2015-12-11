require 'active_record'
require './config/database'
require './app/models/relation'
require './app/models/relations/owner'
require './app/models/article'
require './app/models/universe'

require 'factory_girl'
require './spec/factories'
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

describe "Relation DB" do

  describe "Validations" do
    
    let(:target){ create :article }
    let(:target_id){ target.id }
    let(:origin){ create :article }
    let(:origin_id){ origin.id }
    let(:type){ "Owner" }
    let(:params){{ origin_id:origin_id, target_id:target_id, type:type }}

    subject{ ->{ Relation.create params }}

    context "Participation is valid" do
      it{ should change(Relation,:count).from(0).to(1) }
    end

    context "Type is nil" do
      let(:type){ nil }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::NotNullViolation"
      }} 
    end

    context "Type is blank" do
      let(:type){ "" }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::CheckViolation"
      }} 
    end

    context "Different origins but same target" do
      let(:origin2){ create :article }
      before{ create :relation, origin_id:origin2.id, target_id:target.id }
      it{ should change(Relation,:count).from(1).to(2) }
    end

    context "Same origin but different targets" do
      let(:target2){ create :article }
      before{ create :relation, origin_id:origin.id, target_id:target2.id }
      it{ should change(Relation,:count).from(1).to(2) }
    end

    context "Origin is nil" do
      let(:origin_id){ nil }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::NotNullViolation"
      }} 
    end

    context "Origin is pointing at a non-existing article" do
      let(:origin_id){ -1 }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::InvalidForeignKey
        expect(e.message).to include "PG::ForeignKeyViolation"
      }}
    end

    context "Target is nil" do
      let(:target_id){ nil }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::NotNullViolation"
      }} 
    end

    context "Target is pointing at a non-existing article" do
      let(:target_id){ -1 }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::InvalidForeignKey
        expect(e.message).to include "PG::ForeignKeyViolation"
      }}
    end

    context "Pair origin_id and target_id is duplicated" do
      before{ create :relation, origin_id:origin.id, target_id:target.id }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid 
        expect(e.message).to include "PG::UniqueViolation"
      }}
    end

    after do
      Relation.delete_all
      Article.delete_all
      Universe.delete_all
    end

  end
end

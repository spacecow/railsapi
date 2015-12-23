require 'rails_helper'

describe "Citation DB" do

  describe "Validations" do

    let(:origin){ create :article }
    let(:origin_id){ origin.id }
    let(:target){ create :article }
    let(:target_id){ target.id }
    let(:content){ "some content" }
    let(:params){{ content:content, origin_id:origin_id, target_id:target_id }}

    subject{ ->{ Citation.create params }}

    context "Citation is valid" do
      it{ should change(Citation,:count).from(0).to(1) }
    end

    context "Param content is nil" do
      let(:content){ nil }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::NotNullViolation" }} 
    end

    context "Param content is blank" do
      let(:content){ "" }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::CheckViolation" }} 
    end

    context "Param origin_id is nil" do
      let(:origin_id){ nil }
      it{ should change(Citation,:count).from(0).to(1) }
    end

    context "Param target_id is nil" do
      let(:target_id){ nil }
      it{ should change(Citation,:count).from(0).to(1) }
    end

    context "A non-citation is referenced as origin" do
      let(:origin_id){ -1 }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::ForeignKeyViolation" }} 
    end

    context "A non-citation is referenced as target" do
      let(:target_id){ -1 }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::ForeignKeyViolation" }} 
    end

    after do
      Citation.delete_all
      Article.delete_all
      Universe.delete_all
    end

  end
end

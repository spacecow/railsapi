require 'active_record'
require './config/database'
require './app/models/step'
require './app/models/event'
require './app/models/universe'

require 'factory_girl'
require './spec/factories'
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

describe Step do

  describe "Validations" do

    let(:child){ create :event }
    let(:child_id){ child.id }
    let(:parent){ create :event }
    let(:parent_id){ parent.id }
    let(:params){{ parent_id:parent_id, child_id:child_id }}

    subject{ ->{ Step.create params }}

    context "Step is valid" do
      it{ should change(Step,:count).from(0).to(1) }
    end

    context "Same parent but different children" do
      let(:child2){ create :event }
      before{ create :step, parent_id:parent.id, child_id:child2.id }
      it{ should change(Event,:count).from(2).to(3) }
    end

    context "Different parents but same child" do
      let(:parent2){ create :event }
      before{ create :step, parent_id:parent2.id, child_id:child.id }
      it{ should change(Event,:count).from(2).to(3) }
    end

    context "Param parent_id is nil" do
      let(:parent_id){ nil }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid 
        expect(e.message).to include "PG::NotNullViolation"
      }}
    end

    context "Parent is pointing at a non-existing event" do
      let(:parent_id){ -1 }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::InvalidForeignKey
        expect(e.message).to include "PG::ForeignKeyViolation"
      }}
    end

    context "Param child_id is nil" do
      let(:child_id){ nil }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid 
        expect(e.message).to include "PG::NotNullViolation"
      }}
    end

    context "Child is pointing at a non-existing event" do
      let(:child_id){ -1 }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::InvalidForeignKey
        expect(e.message).to include "PG::ForeignKeyViolation"
      }}
    end

    context "Pair parent_id and child_id is duplicated" do
      before{ create :step, parent_id:parent.id, child_id:child.id }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid 
        expect(e.message).to include "PG::UniqueViolation"
      }}
    end

    after do
      Step.delete_all
      Event.delete_all
      Universe.delete_all
    end

  end
end

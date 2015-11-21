require 'active_record'
require './config/database'
require './app/models/event'
require './app/models/universe'

require 'factory_girl'
require './spec/factories'
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

describe Event do

  describe "Validations" do

    let(:universe){ create :universe }
    let(:universe_id){ universe.id }
    let(:title){ "Red Wedding" }
    let(:params){{ universe_id:universe_id, title:title }}
    subject{ ->{ Event.create params }}

    context "Event is valid" do
      it{ should change(Event,:count).from(0).to(1) }
      after{ Event.delete_all }
    end

    context "Same title but in different universes" do
      let(:universe2){ create :universe }
      before{ create :event, universe_id:universe2.id, title:title }
      it{ should change(Event,:count).from(1).to(2) }
      after{ Event.delete_all }
    end

    context "Same universe but with different titles" do
      before{ create :event, universe_id:universe.id, title:"Green wedding" }
      it{ should change(Event,:count).from(1).to(2) }
      after{ Event.delete_all }
    end

    context "Param universe_id is nil" do
      let(:universe_id){ nil }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid 
        expect(e.message).to include "PG::NotNullViolation"
      }}
    end

    context "Param universe_id is nil" do
      let(:universe_id){ -1 }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::InvalidForeignKey
        expect(e.message).to include "PG::ForeignKeyViolation"
      }}
    end

    context "Param title is nil" do
      let(:title){ nil }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid 
        expect(e.message).to include "PG::NotNullViolation"
      }}
    end

    context "Param title is blank" do
      let(:title){ '' }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid 
        expect(e.message).to include "PG::CheckViolation"
      }}
    end

    context "Pair universe_id and title is duplicated" do
      before{ create :event, universe_id:universe_id, title:title }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid 
        expect(e.message).to include "PG::UniqueViolation"
      }}
      after{ Event.delete_all }
    end

    after{ Universe.delete_all }

  end
end

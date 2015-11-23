require 'active_record'
require './config/database'
require './app/models/participation'

require './app/models/universe'
require './app/models/event'

require 'factory_girl'
require './spec/factories'
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

describe Participation do

  describe "Validations" do
    
    let(:event){ create :event }
    let(:event_id){ event.id }
    subject{ ->{ Participation.create event_id:event_id }}

    #TODO add article association
    #TODO make event and article unique
    context "Participation is valid" do
      it{ should change(Participation,:count).from(0).to(1) }
      after do
        Participation.delete_all
        Event.delete_all
        Universe.delete_all
      end
    end

    context "Event is nil" do
      let(:event_id){ nil }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::NotNullViolation"
      }} 
    end

    context "A non-event is referenced" do
      let(:event_id){ -1 }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::ForeignKeyViolation"
      }} 
    end

  end

end

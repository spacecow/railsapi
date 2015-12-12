require 'active_record'
require './config/database'
require './app/models/event_note'

require './app/models/event'
require './app/models/note'
require './app/models/universe'

require 'factory_girl'
require './spec/factories'
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

describe "EventNote DB, Validations" do

  let(:event){ create :event }
  let(:event_id){ event.id }
  let(:note){ create :note }
  let(:note_id){ note.id }
  let(:params){{ event_id:event_id, note_id:note_id }}

  subject{ ->{ EventNote.create params }}

  context "ArticleNote is valid" do
    it{ should change(EventNote,:count).from(0).to(1) }
  end

  context "Same event, but different notes" do
    let(:note2){ create :note }
    before{ create :event_note, note:note2, event:event }
    it{ should change(EventNote,:count).from(1).to(2) }
  end

  context "Same note, but different events" do
    let(:event2){ create :event }
    before{ create :event_note, note:note, event:event2 }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid 
      expect(e.message).to include "PG::UniqueViolation" }}
  end

  context "Param event_id is nil" do
    let(:event_id){ nil }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid 
      expect(e.message).to include "PG::NotNullViolation"
    }}
  end

  context "Param event_id is pointing at a non-existing event" do
    let(:event_id){ -1 }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::InvalidForeignKey
      expect(e.message).to include "PG::ForeignKeyViolation"
    }}
  end

  context "Param note_id is nil" do
    let(:note_id){ nil }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid 
      expect(e.message).to include "PG::NotNullViolation"
    }}
  end

  context "Param note_id is pointing at a non-existing note" do
    let(:note_id){ -1 }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::InvalidForeignKey
      expect(e.message).to include "PG::ForeignKeyViolation"
    }}
  end

  after do
    EventNote.delete_all
    Note.delete_all
    Event.delete_all
    Universe.delete_all
  end

end

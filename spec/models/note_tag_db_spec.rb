require 'active_record'
require './config/database'
require './app/models/note_tag'

require './app/models/tag'
require './app/models/note'

require 'factory_girl'
require './spec/factories'
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end


describe "NoteTag DB, Validations" do

  let(:note){ create :note }
  let(:note_id){ note.id }
  let(:tag){ create :tag }
  let(:tag_id){ tag.id }
  let(:params){{ note_id:note_id, tag_id:tag_id }}

  subject{ ->{ NoteTag.create params }}

  context "NoteTag is valid" do
    it{ should change(NoteTag,:count).from(0).to(1) }
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

  context "Param tag_id is nil" do
    let(:tag_id){ nil }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid 
      expect(e.message).to include "PG::NotNullViolation"
    }}
  end

  context "Param tag_id is pointing at a non-existing tag" do
    let(:tag_id){ -1 }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::InvalidForeignKey
      expect(e.message).to include "PG::ForeignKeyViolation"
    }}
  end

  context "Pair note_id and tag_id is duplicated" do
    before{ create :note_tag, note_id:note.id, tag_id:tag.id }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid 
      expect(e.message).to include "PG::UniqueViolation"
    }}
  end


  after do
    NoteTag.delete_all
    Tag.delete_all
    Note.delete_all
  end

end

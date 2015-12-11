require 'active_record'
require './config/database'
require './app/models/article_note'

require './app/models/note'
require './app/models/article'
require './app/models/universe'

require 'factory_girl'
require './spec/factories'
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

describe "ArticleNote DB, Validations" do

  let(:note){ create :note }
  let(:note_id){ note.id }
  let(:article){ create :article }
  let(:article_id){ article.id }
  let(:params){{ article_id:article_id, note_id:note_id }}

  subject{ ->{ ArticleNote.create params }}

  context "Participation is valid" do
    it{ should change(ArticleNote,:count).from(0).to(1) }
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

  context "Param article_id is nil" do
    let(:article_id){ nil }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid 
      expect(e.message).to include "PG::NotNullViolation"
    }}
  end

  context "Param article_id is pointing at a non-existing article" do
    let(:article_id){ -1 }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::InvalidForeignKey
      expect(e.message).to include "PG::ForeignKeyViolation"
    }}
  end

  after do
    ArticleNote.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

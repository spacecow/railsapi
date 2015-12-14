require 'active_record'
require './config/database'
require './app/models/article_tag'

require './app/models/tag'
require './app/models/article'
require './app/models/universe'

require 'factory_girl'
require './spec/factories'
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

describe "ArticleTag DB, Validations" do

  let(:article){ create :article }
  let(:article_id){ article.id }
  let(:tag){ create :tag }
  let(:tag_id){ tag.id }
  let(:params){{ article_id:article_id, tag_id:tag_id }}

  subject{ ->{ ArticleTag.create params }}

  context "ArticleNote is valid" do
    it{ should change(ArticleTag,:count).from(0).to(1) }
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

  context "Param tag_id is nil" do
    let(:tag_id){ nil }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid 
      expect(e.message).to include "PG::NotNullViolation"
    }}
  end

  context "Param tag_id is pointing at a non-existing article" do
    let(:tag_id){ -1 }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::InvalidForeignKey
      expect(e.message).to include "PG::ForeignKeyViolation"
    }}
  end

  context "Pair article_id and tag_id is duplicated" do
    before{ create :article_tag, article_id:article.id, tag_id:tag.id }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid 
      expect(e.message).to include "PG::UniqueViolation"
    }}
  end

  after do
    ArticleTag.delete_all
    Tag.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

require 'active_record'
require './config/database'
require './app/models/article_mention'

require './app/models/event'
require './app/models/article'
require './app/models/universe'

require 'factory_girl'
require './spec/factories'
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

describe "ArticleMention DB, Validations" do

  let(:origin){ create :event }
  let(:origin_id){ origin.id }
  let(:target){ create :article }
  let(:target_id){ target.id }
  let(:params){{ origin_id:origin_id, target_id:target_id }}

  subject{ ->{ ArticleMention.create params }}

  context "ArticleNote is valid" do
    it{ should change(ArticleMention,:count).from(0).to(1) }
  end

  context "Param origin_id is nil" do
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

  context "Param target_id is nil" do
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
    before{ create :article_mention, origin_id:origin.id, target_id:target.id }
    it{ should raise_error{|e|
      expect(e).to be_a ActiveRecord::StatementInvalid 
      expect(e.message).to include "PG::UniqueViolation"
    }}
  end

  after do
    ArticleMention.delete_all
    Article.delete_all
    Event.delete_all
    Universe.delete_all
  end

end

require 'active_record'
require './config/database'
require './app/models/remark'
require './app/models/remarkable'

require 'factory_girl'
require './spec/factories'
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

describe Remark do

  describe "Validations" do

    let(:remarkable){ create :remarkable }
    let(:remarkable_id){ remarkable.id }
    let(:content){ "some content" }
    let(:params){{ remarkable_id:remarkable_id, content:content }}
    
    subject{ ->{ Remark.create params }}

    context "Remark is valid" do
      it{ should change(Remark,:count).from(0).to(1) }
    end

    context "content is nil" do
      let(:content){ nil }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::NotNullViolation" }} 
    end

    context "content is blank" do
      let(:content){ "" }
      it{ should raise_error{|e|
        expect(e).to be_a ActiveRecord::StatementInvalid
        expect(e.message).to include "PG::CheckViolation" }} 
    end

    after do
      Remark.delete_all
      Remarkable.delete_all
    end
  
  end
end


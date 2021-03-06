require 'active_record'
require './config/database'
require './lib/repository'

require 'factory_girl'
require './spec/factories'
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

describe Repository do

  let(:repository){ Repository.new }

  subject{ repository.send function, *params }

  describe "#create_note" do
    let(:function){ :create_note }
    #let(:params){[{ article_id:1, event_id:1, {text:'a note'}}]}
    let(:params){[article_id:article_id, event_id:event_id, params:{text:"a note"}]}
    let(:article){ create :article }
    let(:event){ create :event }
    #let(:function){ repo.create_note(
    #  article_id:article_id.to_s, event_id:nil, params:params )} 

    before do
      require './app/models/article'
      require './app/models/article_note'
      require './app/models/event'
      require './app/models/event_note'
      require './app/models/articles/character'
      require './app/models/universe'
      require './app/models/note'
    end

    subject{ repository.create_note *params }

    context "evnet_id is nil" do
      let(:article_id){ article.id }
      let(:event_id){ nil }
      it{ expect{subject}.to change(Note,:count).from(0).to(1).and(
                             change(ArticleNote,:count).from(0).to(1)) }
    end

    context "evnet_id is blank" do
      let(:article_id){ article.id }
      let(:event_id){ "" }
      it{ expect{subject}.to change(Note,:count).from(0).to(1).and(
                             change(ArticleNote,:count).from(0).to(1)) }
    end

    context "article_id is nil" do
      let(:article_id){ nil }
      let(:event_id){ event.id }
      it{ expect{subject}.to change(Note,:count).from(0).to(1).and(
                             change(EventNote,:count).from(0).to(1)) }
    end

    context "article_id is blank" do
      let(:article_id){ "" }
      let(:event_id){ event.id }
      it{ expect{subject}.to change(Note,:count).from(0).to(1).and(
                             change(EventNote,:count).from(0).to(1)) }
    end

    context "article does not exist" do
      let(:article_id){ -1 }
      let(:event_id){ nil }
      it{ expect{ subject }.to raise_error{|e|
          expect(e).to be_a ActiveRecord::RecordNotFound
          expect(e.message).to eq "Couldn't find Article with 'id'=-1"
        } }
    end

    after do
      ArticleNote.delete_all
      EventNote.delete_all
      Note.delete_all
      Event.delete_all
      Article.delete_all
      Universe.delete_all
    end
  end

end

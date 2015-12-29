require 'action_controller'

describe "Api::T1::ArticleMentionsController" do

  let(:controller){ Api::T1::ArticleMentionsController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/article_mentions_controller'
  end
  
  subject{ controller.send function }

  describe "REST" do

    let(:factory){ double :factory }
    let(:article_mention){ double :article_mention }

    before do
      expect(controller).to receive(:factory).with(no_args){ factory }
      expect(article_mention).to receive(:factory_json).with(no_args){ :json }
    end

    describe "#create" do
      let(:function){ :create }
      before do
        expect(controller).to receive(:article_mention_params).
          with(no_args){ :params }
        expect(factory).to receive(:create_article_mention).
          with(:params){ article_mention }
        expect(controller).to receive(:render).
          with(json:{article_mention: :json}){ :render }
      end
      it{ should be :render }
    end
  end

  describe "Private" do
    before{ expect(controller).to receive(:params).with(no_args){ params }}
    describe "#article_mention_params" do
      let(:function){ :article_mention_params }
      let(:params){ ActionController::Parameters.new(params_hash) }
      context "no params" do
        let(:params_hash){ {} } 
        it{ should eq({}) }
      end
      context "with params" do
        let(:params_hash){{ article_mention:{ origin_id: :origin_id,
          target_id: :target_id, content: :content, xxx: :xxx }}} 
        it{ should eq({ "origin_id" => :origin_id, "target_id" => :target_id,
          "content" => :content }) }
      end
    end
  end

end

require 'action_controller'

describe "Api::V1::ArticleMentionsController" do

  let(:controller){ Api::V1::ArticleMentionsController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/v1/article_mentions_controller'
  end
  
  subject{ controller.send function }

  describe "REST" do

    let(:repo){ double :repo }
    let(:mention){ double :mention }

    before do
      expect(controller).to receive(:repo).with(no_args){ repo }
      expect(mention).to receive(:full_json).with(no_args){ :json }
      expect(controller).to receive(:mention_params).with(no_args){ :params }
      expect(controller).to receive(:render).
        with(json:{article_mention: :json}){ :render }
    end

    describe "#create" do
      let(:function){ :create }
      before do
        expect(controller).to receive(:remove_origin_id).
          with(no_args){ :origin_id }
        expect(repo).to receive(:create_article_mention).
          with(origin_id: :origin_id, params: :params){ mention }
      end
      it{ should be :render }
    end

    describe "#update" do
      let(:function){ :update }
      let(:params){{ id: :id }}
      before do
        expect(controller).to receive(:params).with(no_args){ params }
        expect(repo).to receive(:update_article_mention).
          with(:id,:params){ mention }
      end
      it{ should be :render }
    end

  end

  describe "Private" do
    before{ expect(controller).to receive(:params).with(no_args){ params }}
    describe "#mention_params" do
      let(:function){ :mention_params }
      let(:params){ ActionController::Parameters.new(params_hash) }
      context "with params" do
        let(:params_hash){{ article_mention:{ target_id: :target_id,
          content: :content, xxx: :xxx }}} 
        it{ should eq({ "target_id" => :target_id, "content" => :content }) }
      end
    end
    describe "#remove_origin_id" do
      let(:function){ :remove_origin_id }
      let(:params){ ActionController::Parameters.new(params_hash) }
      context "with params" do
        let(:params_hash){{ article_mention:{ origin_id: :origin_id, xxx: :xxx }}} 
        it{ should eq :origin_id }
      end
    end
  end
end

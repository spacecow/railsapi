require 'action_controller'

describe "Api::V1::MentionsController" do

  let(:controller){ Api::V1::MentionsController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/v1/mentions_controller'
  end
  
  subject{ controller.send function }

  describe "REST" do

    let(:repo){ double :repo }
    let(:mention){ double :mention }

    before do
      expect(controller).to receive(:repo).with(no_args){ repo }
      expect(mention).to receive(:full_json).with(no_args){ :json }
    end

    describe "#create" do
      let(:function){ :create }
      before do
        expect(controller).to receive(:remove_origin_id).with(no_args){ :origin_id }
        expect(controller).to receive(:mention_params).with(no_args){ :params }
        expect(repo).to receive(:create_mention).
          with(origin_id: :origin_id,params: :params){ mention }
        expect(controller).to receive(:render).
          with(json:{mention: :json}){ :render }
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
        let(:params_hash){{ mention:{ target_id: :target_id, xxx: :xxx }}} 
        it{ should eq({ "target_id" => :target_id }) }
      end
    end
    describe "#remove_origin_id" do
      let(:function){ :remove_origin_id }
      let(:params){ ActionController::Parameters.new(params_hash) }
      context "with params" do
        let(:params_hash){{ mention:{ origin_id: :origin_id, xxx: :xxx }}} 
        it{ should eq :origin_id }
      end
    end
  end
end

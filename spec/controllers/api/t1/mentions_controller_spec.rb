require 'action_controller'

describe "Api::T1::MentionsController" do

  let(:controller){ Api::T1::MentionsController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/mentions_controller'
  end
  
  subject{ controller.send function }

  describe "REST" do

    let(:factory){ double :factory }
    let(:mention){ double :mention }

    before do
      expect(controller).to receive(:factory).with(no_args){ factory }
      expect(mention).to receive(:factory_json).with(no_args){ :json }
    end

    describe "#create" do
      let(:function){ :create }
      before do
        expect(controller).to receive(:mention_params).with(no_args){ :params }
        expect(factory).to receive(:create_mention).with(:params){ mention }
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
      context "no params" do
        let(:params_hash){ {} } 
        it{ should eq({}) }
      end
      context "with params" do
        let(:params_hash){{ mention:{
          origin_id: :origin_id, xxx: :xxx }}} 
        it{ should eq({ "origin_id" => :origin_id }) }
      end
    end
  end


end

require 'action_controller'

describe "Api::T1::CitationsController" do

  let(:controller){ Api::T1::CitationsController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/citations_controller'
  end

  subject{ controller.send function }

  describe "REST" do

    let(:factory){ double :factory }
    let(:citation){ double :citation }

    before do
      expect(controller).to receive(:factory).with(no_args){ factory }
      expect(citation).to receive(:factory_json).with(no_args){ :json }
    end

    describe "#create" do
      let(:function){ :create }
      before do
        expect(controller).to receive(:citation_params).with(no_args){ :params }
        expect(factory).to receive(:create_citation).with(:params){ citation }
        expect(controller).to receive(:render).
          with(json:{citation: :json}){ :render }
      end
      it{ should eq :render }
    end

    describe "#delete_all" do
      let(:function){ :delete_all }
      before do
        expect(factory).to receive(:delete_citations).with(no_args){ [citation] }
        expect(controller).to receive(:render).
          with(json:{citations:[:json]}){ :render }
      end
      it{ should eq :render }
    end
  end

  describe "Private" do
    before{ expect(controller).to receive(:params).with(no_args){ params }}
    describe "#citation_params" do
      let(:function){ :citation_params }
      let(:params){ ActionController::Parameters.new(params_hash) }
      context "no params" do
        let(:params_hash){ {} } 
        it{ should eq({}) }
      end
      context "with params" do
        let(:params_hash){{ citation:{ content: :content, origin_id: :origin_id,
          target_id: :target_id, xxx: :xxx }}} 
        it{ should eq("content" => :content, "origin_id" => :origin_id,
          "target_id" => :target_id ) }
      end
    end
  end

end

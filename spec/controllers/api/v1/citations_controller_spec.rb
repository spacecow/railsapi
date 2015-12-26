require 'action_controller'

describe "Api::V1::CitationsController" do

  let(:controller){ Api::V1::CitationsController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/v1/citations_controller'
  end
  
  subject{ controller.send function }

  describe "REST" do

    let(:repo){ double :repo }
    let(:citation){ double :citation }

    before do
      expect(controller).to receive(:repo).with(no_args){ repo }
      expect(citation).to receive(:full_json).with(no_args){ :json }
    end

    describe "#create" do
      let(:function){ :create }
      before do
        #expect(controller).to receive(:remove_origin_id).with(no_args){ :origin_id }
        expect(controller).to receive(:citation_params).with(no_args){ :params }
        expect(repo).to receive(:create_citation).with(:params){ citation }
        expect(controller).to receive(:render).
          with(json:{citation: :json}){ :render }
      end
      it{ subject }
    end
  end

  describe "Private" do
    before{ expect(controller).to receive(:params).with(no_args){ params }}
    describe "#citation_params" do
      let(:function){ :citation_params }
      let(:params){ ActionController::Parameters.new(params_hash) }
      context "with params" do
        let(:params_hash){{ citation:{ content: :content, origin_id: :origin_id,
          target_id: :target_id, xxx: :xxx }}} 
        it{ should eq({ "content" => :content, "origin_id" => :origin_id,
          "target_id" => :target_id }) }
      end
    end
  end

end

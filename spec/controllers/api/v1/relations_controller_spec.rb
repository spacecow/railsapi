describe "RelationsController" do

  let(:controller){ Api::V1::RelationsController.new }
  let(:repo){ double :repo }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/v1/relations_controller'
    allow(controller).to receive(:repo).with(no_args){ repo }
    def controller.params; raise NotImplementedError end
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    let(:relation){ double :relation }
    before do
      expect(controller).to receive(:render).
        with(json:{relation: :json}){ :render }
      expect(repo).to receive(:relation).with(:id){ relation }
      expect(relation).to receive(:full_json).with(no_args){ :json }
    end
    it{ subject }
  end

  describe "#create" do
    let(:function){ :create }
    before do
      expect(controller).to receive(:relation_params).with(no_args){ :params }
      expect(controller).to receive(:render).
        with(json:{relation: :relation}){ :render }
      expect(repo).to receive(:create_relation).with(:params){ :relation }
    end
    it{ should be :render }
  end

  describe "#delete_all" do
    let(:function){ :delete_all }
    before do
      expect(repo).to receive(:delete_relations).with(no_args){ :relations }
      expect(controller).to receive(:render).
        with(json:{relations: :relations}){ :render }
    end
    it{ should be :render }
  end

end

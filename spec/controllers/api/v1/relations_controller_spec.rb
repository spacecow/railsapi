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
    let(:relation){ double :relation }
    before do
      expect(controller).to receive(:relation_params).with(no_args){ :params }
      expect(controller).to receive(:render).
        with(json:{relation: :json}){ :render }
      expect(repo).to receive(:create_relation).with(:params){ relation }
      expect(relation).to receive(:full_json).with(no_args){ :json }
    end
    it{ should be :render }
  end

  describe "#update" do
    let(:function){ :update }
    let(:params){{ id: :id }}
    before do
      expect(controller).to receive(:relation_params).with(no_args){ :params }
      expect(controller).to receive(:render).with(json:{}){ :render }
      expect(repo).to receive(:update_relation).with(:id, :params)
    end
    it{ should be :render }
  end

  describe "#delete_all" do
    let(:function){ :delete_all }
    let(:relation){ double :relation }
    before do
      expect(repo).to receive(:delete_relations).with(no_args){ [relation] }
      expect(controller).to receive(:render).
        with(json:{relations:[:json]}){ :render }
      expect(relation).to receive(:full_json).with(no_args){ :json }
    end
    it{ should be :render }
  end

end

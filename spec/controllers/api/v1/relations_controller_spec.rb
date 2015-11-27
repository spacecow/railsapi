describe "RelationsController" do

  let(:controller){ Api::V1::RelationsController.new }
  let(:repo){ double :repo }

  before do
    module Api; module V1; class ApplicationController
    end end end unless defined?(Rails)
    require './app/controllers/api/v1/relations_controller'
    allow(controller).to receive(:repo).with(no_args){ repo }
  end

  subject{ controller.send function }

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

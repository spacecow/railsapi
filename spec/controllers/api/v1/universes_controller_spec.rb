describe "UniversesController" do

  let(:controller){ Api::V1::UniversesController.new }
  let(:params){ double :params }
  let(:universe_params){ double :universe_params }
  let(:permitted_params){ %i(title) }
  let(:repo){ double :repo }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/v1/universes_controller'
    allow(controller).to receive(:params).with(no_args){ params }
    allow(controller).to receive(:repo).with(no_args){ repo }
  end

  subject{ controller.send function }

  describe "#show" do
    let(:function){ :show }
    let(:params){{ id: :id }}
    before do
      expect(repo).to receive(:universe).with(:id){ :universe }
      expect(repo).to receive(:universe_as_json).with(:universe){ :json }
      expect(controller).to receive(:render).
        with(json:{universe: :json}){ :render }
    end
    it{ should be :render }
  end

  describe "#index" do
    let(:function){ :index }
    before do
      expect(repo).to receive(:universes).with(no_args){ :universes }
      expect(controller).to receive(:render).
        with(json:{universes: :universes}){ :render }
    end
    it{ should be :render }
  end

  describe "#create" do
    let(:function){ :create }
    before do
      expect(controller).to receive(:universe_params).with(no_args){ :params }
      expect(repo).to receive(:create_universe).with(:params){ :universe }
      expect(controller).to receive(:render).
        with(json:{universe: :universe}){ :render }
    end
    it{ should be :render }
  end

  describe "#delete_all" do
    let(:function){ :delete_all }
    before do
      expect(repo).to receive(:delete_universes).with(no_args){ :universes }
      expect(controller).to receive(:render).
        with(json:{universes: :universes}){ :render }
    end
    it{ should be :render }
  end

  describe "#universe_params" do
    let(:function){ :universe_params }
    before do
      expect(controller).to receive(:params){ params }
      expect(params).to receive(:require).
        with(:universe){ universe_params }
      expect(universe_params).to receive(:permit).
        with(*permitted_params){ :params }
    end
    it{ is_expected.to be :params }
  end

end

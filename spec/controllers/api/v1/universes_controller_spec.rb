describe "UniversesController" do

  let(:controller){ Api::V1::UniversesController.new }
  let(:params){ double :params }
  let(:universe_params){ double :universe_params }
  let(:permitted_attributes){ %i(title) }

  before do
    require './spec/controller_helper'
    require './app/controllers/api/v1/universes_controller'
  end

  describe "universe_params" do
    subject{ controller.send(:universe_params) }
    before do
      expect(controller).to receive(:params){ params }
      expect(params).to receive(:require).
        with(:universe){ universe_params }
      expect(universe_params).to receive(:permit).
        with(*permitted_attributes){ :params }
    end
    it{ is_expected.to be :params }
  end

end

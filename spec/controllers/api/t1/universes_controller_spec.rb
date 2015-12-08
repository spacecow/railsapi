describe "Api::T1::UniversesController" do

  let(:controller){ Api::T1::UniversesController.new }
  let(:factory){ double :factory }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/universes_controller'
    expect(controller).to receive(:factory).with(no_args){ factory }
  end

  subject{ controller.send function }

  describe "#delete_all" do
    let(:function){ :delete_all }
    let(:universe){ double :universe }
    before do
      expect(factory).to receive(:delete_universes).with(no_args){ [universe] }
      expect(universe).to receive(:factory_json).with(no_args){ :json }
      expect(controller).to receive(:render).with(json:{universes:[:json]}){ :render }
    end
    it{ subject }
  end

end

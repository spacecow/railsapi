describe "Api::T1::UniversesController" do

  let(:controller){ Api::T1::UniversesController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/universes_controller'
  end

  subject{ controller.send function }

  describe "REST" do

    let(:factory){ double :factory }
    let(:universe){ double :universe }

    before do
      expect(controller).to receive(:factory).with(no_args){ factory }
      expect(universe).to receive(:factory_json).with(no_args){ :json }
    end

    describe "#delete_all" do
      let(:function){ :delete_all }
      before do
        expect(factory).to receive(:delete_universes).with(no_args){ [universe] }
        expect(controller).to receive(:render).with(json:{universes:[:json]}){ :render }
      end
      it{ should be :render }
    end

  end

end

describe "Api::T1::ParticipationsController" do

  let(:controller){ Api::T1::ParticipationsController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/participations_controller'
  end

  subject{ controller.send function }

  describe "REST" do

    let(:factory){ double :factory }
    let(:participation){ double :participation }

    before do
      expect(controller).to receive(:factory).with(no_args){ factory }
      expect(participation).to receive(:factory_json).with(no_args){ :json }
    end

    describe "#create" do
      let(:function){ :create }
      before do
        expect(controller).to receive(:participation_params).with(no_args){ :params }
        expect(factory).to receive(:create_participation).
          with(:params){ participation }
        expect(controller).to receive(:render).
          with(json:{participation: :json}){ :render }
      end
      it{ should be :render }
    end

  end

  describe "Private" do

    xdescribe "#participation_params" do
      let(:function){ :participation_params }
      it{ subject }
    end

  end

end

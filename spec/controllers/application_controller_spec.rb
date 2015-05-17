describe "ApplicationContoller" do

  let(:controller){ ApplicationController.new }
  let(:record_invalid_msg){ 'record in question is invalid' }
  let(:record_missing_msg){ 'record in question is missing' }

  before{ require './spec/controller_helper' }

  describe "#record_invalid" do
    subject{ controller.record_invalid }
    before do
      expect(controller).to receive(:render).
        with(json:{error:record_invalid_msg}){ :json }
    end
    it{ is_expected.to eq :json }
  end

  describe "#record_missing" do
    subject{ controller.record_missing }
    before do
      expect(controller).to receive(:render).
        with(json:{error:record_missing_msg}){ :json }
    end
    it{ is_expected.to eq :json }
  end
 
end

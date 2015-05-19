describe "ApplicationContoller" do

  let(:controller){ ApplicationController.new }
  let(:record_invalid_msg){ 'record in question is invalid' }
  let(:record_missing_msg){ 'record in question is missing' }
  let(:record_not_found_msg){ 'record in question is not found' }

  before{ require './spec/controller_helper' }

  subject{ controller.send function }

  describe "#record_invalid" do
    let(:function){ :record_invalid }
    before do
      expect(controller).to receive(:render).with(json:{
          error:record_invalid_msg,
          class:ActiveRecord::StatementInvalid.to_s}){ :json }
    end
    it{ is_expected.to eq :json }
  end

  describe "#record_missing" do
    let(:function){ :record_missing }
    before do
      expect(controller).to receive(:render).with(json:{
        error:record_missing_msg,
        class:ActionController::ParameterMissing.to_s}){ :json }
    end
    it{ is_expected.to eq :json }
  end

  describe "#record_not_found" do
    let(:function){ :record_not_found }
    before do
      expect(controller).to receive(:render).with(json:{
        error:record_not_found_msg,
        class:ActiveRecord::RecordNotFound.to_s}){ :json }
    end
    it{ is_expected.to eq :json }
  end
 
end

describe "ApplicationContoller" do

  let(:controller){ ApplicationController.new }
  let(:record_invalid_msg){ 'record in question is invalid' }
  let(:record_missing_msg){ 'record in question is missing' }
  let(:record_not_found_msg){ 'record in question is not found' }

  before{ require './spec/controller_helper' }

  let(:params){ [] }
  subject{ controller.send function, *params }

  describe "#record_invalid" do
    let(:msg){ 'null value in column "title" INSERT INTO "universes"' }
    let(:error){ double :error, message:msg }
    let(:params){ error }
    let(:function){ :record_invalid }
    before do
      expect(controller).to receive(:render).with(
        status: :bad_request,
        json:{universe:{title:'cannot be null'}}){ :json }  
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

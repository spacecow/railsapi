describe "ApplicationContoller" do

  let(:controller){ ApplicationController.new }
  let(:record_missing_msg){ 'record in question is missing' }
  let(:record_not_found_msg){ 'record in question is not found' }

  before{ require './spec/controller_helper' }

  let(:error){ double :error, message:msg }
  let(:params){ [] }
  subject{ controller.send function, *params }

  describe "#record_invalid" do
    let(:params){ error }
    let(:function){ :record_invalid }

    context "value is null" do
      let(:msg){ 'null value in column "title" INSERT INTO "universes"' }
      before do
        expect(controller).to receive(:render).with(
          status: :bad_request,
          json:{universe:{title:'cannot be null'}}){ :json }  
      end
      it{ is_expected.to eq :json }
    end

    context "value is blank" do
      let(:msg){ 'check constraint "title_cannot_be_blank" INSERT INTO "universes"' }
      before do
        expect(controller).to receive(:render).with(
          status: :bad_request,
          json:{universe:{title:'cannot be blank'}}){ :json }  
      end
      it{ is_expected.to eq :json }
    end
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

  describe "#record_not_unique" do
    let(:msg){ 'duplicate key "index_universes_on_title" INSERT INTO "universes"' }
    let(:params){ error }
    let(:function){ :record_not_unique }
    before do
      expect(controller).to receive(:render).with(
        status: :bad_request,
        json:{universe:{title:'must be unique'}}){ :json }  
    end
    it{ is_expected.to eq :json }
  end
 
end

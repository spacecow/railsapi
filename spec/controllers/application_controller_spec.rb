require 'active_support/all'

describe "ApplicationContoller" do

  let(:controller){ ApplicationController.new }
  let(:record_missing_msg){ 'record in question is missing' }
  let(:record_not_found_msg){ 'record in question is not found' }

  before{ require './spec/controller_helper' }

  let(:error){ double :error, message:msg }
  let(:params){ error }
  subject{ controller.send function, *params }

  describe "#record_invalid" do
    let(:function){ :record_invalid }

    context "value is invalid enum" do
      let(:msg){ "PG::InvalidTextRepresentation: ERROR:  invalid input value for enum tagable_type_enum: \"basj\"\n: INSERT INTO \"tags\" (\"title\", \"tagable_id\", \"tagable_type\") VALUES ($1, $2, $3) RETURNING \"id\"" }
      before do
        expect(controller).to receive(:render).with(
          status: :bad_request,
          json:{tag:{tagable_type:'incorrect type'}}){ :json }  
      end
      it{ is_expected.to eq :json }
    end

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

  describe "#nested_parameter_missing" do
    let(:msg){ "param is missing or the value is empty: universe" }
    let(:function){ :nested_parameter_missing }
    before do
      expect(controller).to receive(:render).with(
        status: :bad_request,
        json:{universe:'has missing params'}){ :json }  
    end
    it{ is_expected.to eq :json }
  end

  describe "#record_not_found" do
    let(:function){ :record_not_found }
    let(:msg){ "Couldn't find Universe with 'id'" }
    before do
      expect(controller).to receive(:render).with(
        status: :bad_request,
        json:{universe:{id:'is not found'}}){ :json }  
    end
    it{ is_expected.to eq :json }
  end

  describe "#record_not_unique" do
    let(:msg){ 'duplicate key "index_universes_on_title" INSERT INTO "universes"' }
    let(:function){ :record_not_unique }
    before do
      expect(controller).to receive(:render).with(
        status: :bad_request,
        json:{universe:{title:'is already taken'}}){ :json }  
    end
    it{ is_expected.to eq :json }
  end
 
end

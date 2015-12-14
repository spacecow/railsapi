require 'action_controller'

describe "TagsController" do

  let(:controller){ Api::T1::TagsController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/tags_controller'
  end

  subject{ controller.send function }

  describe "REST" do

    let(:factory){ double :factory }
    let(:tag){ double :tag }

    before do
      expect(controller).to receive(:factory).with(no_args){ factory }
      expect(tag).to receive(:factory_json).with(no_args){ :json }
    end

    describe "#create" do
      let(:function){ :create }
      before do
        expect(controller).to receive(:tag_params).with(no_args){ :params }
        expect(factory).to receive(:create_tag).with(:params){ tag }
        expect(controller).to receive(:render).with(json:{tag: :json}){ :render }
      end
      it{ should be :render }
    end

    describe "#delete_all" do
      let(:function){ :delete_all }
      before do
        expect(factory).to receive(:delete_tags).with(no_args){ [tag] }
        expect(controller).to receive(:render).with(json:{tags:[:json]}){ :render }
      end
      it{ should be :render }
    end
  end

  describe "Private" do

    before{ expect(controller).to receive(:params).with(no_args){ params }}

    describe "#tag_params" do
      let(:function){ :tag_params }
      let(:params){ ActionController::Parameters.new(params_hash) }
    
      context "no params" do
        let(:params_hash){ {} } 
        it{ should eq({}) }
      end

      context "with params" do
        let(:params_hash){{ tag:{ tagable_id: :tagable_id,
          tagable_type: :tagable_type, title: :title, xxx: :xxx }}} 
        it{ should eq({ tagable_type: :tagable_type, tagable_id: :tagable_id,
          title: :title }) }
      end

    end
  end

end

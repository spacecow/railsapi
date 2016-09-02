require 'action_controller'

describe "Api::V1::TagsController" do

  let(:controller){ Api::V1::TagsController.new }
  let(:params){ double :params }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/v1/tags_controller'
  end

  subject{ controller.send function }

  describe "REST" do
    let(:repo){ double :repo }
    before{ expect(controller).to receive(:repo).with(no_args){ repo }}

    describe "#destroy" do
      let(:function){ :destroy }
      let(:params){{ id: :id, tag:{ tagable_type:'Note' }}}
      before do
        allow(controller).to receive(:params).with(no_args){ params }
        expect(repo).to receive(:delete_tag).with(:id, tagable_type:'Note')
        expect(controller).to receive(:render).with(nothing:true){ :render }
      end
      it{ should be :render }
    end
  end

  describe "#tag_params" do
    let(:function){ :tag_params }
    let(:tag_params){ double :tag_params }
    before do
      expect(controller).to receive(:params).with(no_args){ params }
      expect(params).to receive(:require).with(:tag){ tag_params }
      expect(tag_params).to receive(:permit).with(:title){ :params }
    end
    it{ should be :params }
  end

  describe "#remove_universe_id" do
    let(:function){ :remove_universe_id }
    before do
      expect(controller).to receive(:params).with(no_args){ params }
      expect(params).to receive(:require).with(:tag){{ universe_id: :universe_id }}
    end
    it{ should be :universe_id }
  end

end


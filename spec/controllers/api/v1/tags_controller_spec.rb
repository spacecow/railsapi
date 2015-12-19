require 'action_controller'

describe "Api::V1::TagsController" do

  let(:controller){ Api::V1::TagsController.new }

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
      let(:params){{ id: :id, tag:{ a:1 }}}
      before do
        allow(controller).to receive(:params).with(no_args){ params }
        expect(repo).to receive(:delete_tag).with(:id, a:1)
        expect(controller).to receive(:render).with(nothing:true){ :render }
      end
      it{ should be :render }
    end
  end

end


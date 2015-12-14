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
  end

end

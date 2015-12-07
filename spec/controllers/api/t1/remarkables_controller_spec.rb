describe "Api::T1::RemarkablesController" do

  let(:controller){ Api::T1::RemarkablesController.new }
  let(:repo){ double :repo }

  before do
    class ApplicationController; end unless defined?(Rails)
    class FactoryGirl; end unless defined?(Rails)
    require './app/controllers/api/t1/remarkables_controller'
    allow(controller).to receive(:repo).with(no_args){ repo }
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    let(:params){{ remarkable: :params }}
    let(:remarkable){ double :remarkable }
    before do
      expect(FactoryGirl).to receive(:create).
        with(:remarkable,:params){ remarkable } 
      expect(remarkable).to receive(:full_json).with(no_args){ :json }
      expect(controller).to receive(:render).
        with(json:{remarkable: :json}){ :render }
    end
    it{ should be :render }
  end

end

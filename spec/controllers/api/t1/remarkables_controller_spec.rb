describe "Api::T1::RemarkablesController" do

  let(:controller){ Api::T1::RemarkablesController.new }
  let(:factory){ double :factory }

  before do
    class ApplicationController; end unless defined?(Rails)
    class FactoryGirl; end unless defined?(Rails)
    require './app/controllers/api/t1/remarkables_controller'
    expect(controller).to receive(:factory).with(no_args){ factory }
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    let(:params){{ remarkable: :params }}
    let(:remarkable){ double :remarkable }
    before do
      expect(factory).to receive(:create_remarkable).with(:params){ remarkable } 
      expect(remarkable).to receive(:full_json).with(no_args){ :json }
      expect(controller).to receive(:render).
        with(json:{remarkable: :json}){ :render }
    end
    it{ should be :render }
  end

end

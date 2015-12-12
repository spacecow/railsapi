describe "Api::T1::RemarksController" do

  let(:controller){ Api::T1::RemarksController.new }
  let(:factory){ double :factory }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/t1/remarks_controller'
    expect(controller).to receive(:factory).with(no_args){ factory }
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    let(:params){{ remark: :params }}
    let(:remark){ double :remark }
    before do
      expect(factory).to receive(:create_remark).with(:params){ remark } 
      expect(remark).to receive(:full_json).with(no_args){ :json }
      expect(controller).to receive(:render).
        with(json:{remark: :json}){ :render }
    end
    it{ should be :render }
  end

end

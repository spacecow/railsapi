describe "Api::V1::RemarksController" do

  let(:controller){ Api::V1::RemarksController.new }
  let(:repo){ double :repo }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/v1/remarks_controller'
    expect(controller).to receive(:repo).with(no_args).at_least(1){ repo }
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    let(:params){{ event_id: :event_id }}
    let(:remark){ double :remark }
    before do
      expect(controller).to receive(:render).with(json:{remark: :json}){ :render }
      expect(controller).to receive(:remark_params).with(:event){ :params }
      expect(repo).to receive(:event).with(:event_id){ :event }
      expect(repo).to receive(:create_remark).with(:params){ remark }
      expect(remark).to receive(:full_json).with(no_args){ :json }
    end
    it{ should be :render }
  end

end

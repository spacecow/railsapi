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

  describe "#update" do
    let(:function){ :update }
    let(:params){{ id: :id }}
    let(:remark){ double :remark }
    before do
      expect(controller).to receive(:remark_params).with(no_args){ :params }
      expect(controller).to receive(:render).with(json:{remark: :json}){ :render }
      expect(repo).to receive(:remark).with(:id){ remark }
      expect(repo).to receive(:update_remark).with(remark,:params)
      expect(remark).to receive(:full_json).with(no_args){ :json }
    end
    it{ should be :render }
  end

  describe "#delete_all" do
    let(:function){ :delete_all }
    let(:remark){ double :remark }
    before do
      expect(repo).to receive(:delete_remarks).with(no_args){ [remark] }
      expect(remark).to receive(:full_json).with(no_args){ :json }
      expect(controller).to receive(:render).
        with(json:{remarks:[:json]}){ :render }
    end
    it{ subject }
  end

end

describe "Api::V1::RemarkableController" do

  let(:controller){ Api::V1::RemarkablesController.new }
  let(:repo){ double :repo }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/api/v1/remarkables_controller'
    expect(controller).to receive(:repo).with(no_args){ repo }
  end

  subject{ controller.send function }

  describe "#delete_all" do
    let(:function){ :delete_all }
    let(:remarkable){ double :remarkable }
    before do
      expect(repo).to receive(:delete_remarkables).with(no_args){ [remarkable] }
      expect(remarkable).to receive(:full_json).with(no_args){ :json }
      expect(controller).to receive(:render).
        with(json:{remarkables:[:json]}){ :render }
    end
    it{ subject }
  end

end

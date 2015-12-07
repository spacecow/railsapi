require 'rails_helper'

describe "Create remark" do

  let(:driver){ Capybara.current_session.driver }
  let(:path){ send "api_#{mdl.pluralize}_path" }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:header){ driver.header 'Accept', 'application/vnd.example.v1' }
  let(:mode){ :post }

  let(:params){{ event_id:event.id, remark:{ content:"some content" }}}
  let(:mdl){ "remark" }
  let(:remark){ Remark.first }
  let(:remarkable){ create :remarkable }
  let(:event){ create :event, remarkable_id:remarkable_id }

  before{ header; event }

  subject{ ->{ driver.submit mode, path, params }}

  context "Without prior remarks" do
    let(:remarkable_id){ nil }
    it "Successfully" do
      should change(Remark,:count).from(0).to(1).and(
             change(Remarkable,:count).from(0).to(1))
      expect(response).to eq({
        'id'      => remark.id,
        'content' => "some content" })
      expect(remark.content).to eq "some content"
      expect(remark.remarkable_id).to be Remarkable.first.id 
      expect(event.reload.remarkable_id).to be Remarkable.first.id
    end
  end

  context "Has prior remarks" do
    let(:remarkable_id){ remarkable.id }
    it "Successfully" do
      should change(Remark,:count).from(0).to(1).and(
             change(Remarkable,:count).by(0))
      expect(response).to eq({
        'id'      => remark.id,
        'content' => "some content" })
      expect(remark.content).to eq "some content"
      expect(remark.remarkable_id).to be remarkable.id 
      expect(event.reload.remarkable_id).to be remarkable.id 
    end
  end

  after do
    Remark.delete_all
    Event.delete_all
    Remarkable.delete_all
    Universe.delete_all
  end

end

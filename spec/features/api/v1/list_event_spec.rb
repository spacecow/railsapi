require 'rails_helper'

describe "List events" do

  let(:event){ create :event, title:"The horse ride" }
  let(:event2){ create :event, title:"Red wedding" }
  let(:response){ JSON.parse(page.text)['events'] }

  context "events response" do
    before do
      event; event2
      visit api_events_path(universe_id:event2.universe_id)
    end
    it{ expect(response).to eq(
    [ "id"    => event2.id,
      "title" => "Red wedding" ])}
  end

  after do
    Event.delete_all
    Universe.delete_all
  end

end

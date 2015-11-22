require 'rails_helper'

describe "List events" do

  let(:event){ create :event, title:"Red wedding" }

  context "events response" do
    subject{ JSON.parse(page.text)['events'] }
    before do
      event
      visit api_events_path
    end
    it{ should eq(
    [ "id"    => event.id,
      "title" => "Red wedding" ])}
  end

  after do
    Event.delete_all
    Universe.delete_all
  end

end

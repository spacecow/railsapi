require 'rails_helper'

describe "Create event" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text) }
  
  let(:universe){ create :universe }
  let(:event){ Event.first }

  subject{ ->{ driver.submit :post, api_events_path, params }}

  context "event is valid" do
    let(:params){{ event:{universe_id:universe.id} }}
    it "an event is created" do
      should change(Event,:count).from(0).to(1)
      expect(response["event"]).to eq(
      { 'id' => event.id })
      expect(event.universe_id).to be universe.id 
    end

    after do
      Event.delete_all
      Universe.delete_all
    end
  end
 
end

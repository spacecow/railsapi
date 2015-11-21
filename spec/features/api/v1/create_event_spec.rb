require 'rails_helper'

describe "Create event" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text) }
  let(:event){ Event.first }

  subject{ ->{ driver.submit :post, api_events_path, params }}

  context "event is valid" do
    let(:params){ {} }
    it "an event is created" do
      should change(Event, :count).from(0).to(1)
      expect(response["event"]).to eq(
      { 'id' => event.id
      })
    end

    after do
      Event.delete_all
    end
  end
 
end

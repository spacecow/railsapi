require 'rails_helper'

describe "Create event" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text) }
  
  let(:universe){ create :universe }
  let(:parent){ create :event }
  let(:event){ Event.last }

  subject{ ->{ driver.submit :post, api_events_path, params }}

  context "event is valid" do
    let(:params){{ event:
    { universe_id:universe.id, title:"Red wedding", parent_id:parent.id }}}
    before{ parent }
    it "an event is created" do
      should change(Event,:count).from(1).to(2)
      expect(response["event"]).to eq(
      { "id" => event.id,
        "title" => "Red wedding",
        "parent_id" => parent.id })
      expect(event.universe_id).to be universe.id 
    end

    after do
      Event.delete_all
      Universe.delete_all
    end
  end
 
end

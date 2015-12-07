require 'rails_helper'

describe "Create event" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text) }
  let(:header){ driver.header 'Accept', 'application/vnd.example.v1' }
  
  let(:universe){ create :universe }
  let(:parent){ create :event }
  let(:child){ create :event }
  let(:event){ Event.last }

  before{ header }

  subject{ ->{ driver.submit :post, api_events_path, params }}

  context "event is valid" do
    let(:params){{ event:
    { universe_id:universe.id, title:"Red wedding",
      parent_tokens:parent.id, child_tokens:child.id }}}
    before{ parent; child }
    it "creates an event" do
      should change(Event,:count).from(2).to(3)
      expect(response["event"]).to eq(
      { "id" => event.id,
        "title" => "Red wedding" })
      expect(event.universe_id).to be universe.id 
      parent_step = Step.first
      expect(parent_step.parent_id).to be parent.id
      expect(parent_step.child_id).to be event.id
      child_step = Step.last
      expect(child_step.parent_id).to be event.id
      expect(child_step.child_id).to be child.id
    end

    after do
      Step.delete_all
      Event.delete_all
      Universe.delete_all
    end
  end
 
end

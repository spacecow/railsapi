require 'rails_helper'

describe "Show event" do

  let(:event){ create :event, title:"Red wedding" }

  before do
    visit api_event_path event
  end

  subject(:response){ JSON.parse(page.text)['event'] }

  it "Event exists" do
    should eq(
    { 'id'    => event.id,
      'title' => "Red wedding" })
  end

  after do
    Event.delete_all
    Universe.delete_all
  end
    

end

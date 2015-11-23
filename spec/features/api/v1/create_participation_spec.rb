require 'rails_helper'

describe "Create participation" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:function){ driver.submit mode, path, params }
  let(:path){ send("api_#{mdl.pluralize}_path") }

  let(:mode){ :post }
  let(:params){{ participation:{ event_id:event.id }}}
  let(:mdl){ "participation" }

  let(:participation){ Participation.last }
  let(:event){ create :event }

  subject{ ->{ function }}

  it "a participation is created" do
    should change(Participation,:count).from(0).to(1)
    expect(response).to eq(
    { 'id'       => participation.id,
      'event_id' => event.id })
  end

  after do
    Participation.delete_all
    Event.delete_all
    Universe.delete_all
  end

end

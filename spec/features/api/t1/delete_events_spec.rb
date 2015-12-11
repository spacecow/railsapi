require 'rails_helper'

describe "Delete events" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdls}_path" }
  let(:mdls){ mdl.pluralize }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdls] }

  let(:mdl){ "event" }
  let(:event){ create :event }

  before{ header; event }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Successfully" do
    should change(Event,:count).from(1).to(0)
    expect(response).to be 1 
  end

  after do
    Event.delete_all
    Universe.delete_all
  end

end

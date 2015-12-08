require 'rails_helper'

describe "Delete events" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdls] }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:path){ send "api_#{mdls}_path" }
  let(:mode){ :delete }
  let(:mdls){ mdl.pluralize }

  let(:mdl){ "event" }
  let(:event){ create :event }

  before{ header; event }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Existing remarks are deleted" do
    should change(Event,:count).from(1).to(0)
    expect(response).to be 1 
  end

  after do
    Event.delete_all
    Universe.delete_all
  end

end

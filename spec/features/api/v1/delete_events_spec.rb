require 'rails_helper'

describe "Delete events" do

  let(:driver){ Capybara.current_session.driver }
  let(:path){ api_events_path }
  let(:event){ create :event }

  before{ event }

  subject{ ->{ driver.submit :delete, path, nil }}

  it "existing events are deleted" do
    should change(Event,:count).from(1).to(0)
  end

  after{ Universe.delete_all }

end

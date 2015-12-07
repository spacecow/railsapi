require 'rails_helper'

describe "Delete remarkables" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdls] }
  let(:path){ send "api_#{mdls}_path" }
  let(:mode){ :delete }

  let(:mdls){ "remarkables" }
  let(:remarkable){ create :remarkable }

  before{ remarkable } 

  subject{ ->{ driver.submit mode, path, nil }}

  it "Existing remarks are deleted" do
    should change(Remarkable,:count).from(1).to(0)
    expect(response).to eq([{
      'id' => remarkable.id }])
  end

  after do
    Remarkable.delete_all
  end

end

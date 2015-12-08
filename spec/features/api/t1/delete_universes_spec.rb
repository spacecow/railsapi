require 'rails_helper'

describe "Delete universes" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdls] }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:path){ send "api_#{mdls}_path" }
  let(:mode){ :delete }
  let(:mdls){ mdl.pluralize }

  let(:mdl){ "universe" }
  let(:universe){ create :universe, title:"The Path of Daggers" }

  before{ header; universe }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Existing remarks are deleted" do
    should change(Universe,:count).from(1).to(0)
    expect(response).to eq([{
      'id'    => universe.id,
      'title' => "The Path of Daggers" }])
  end

  after do
    Universe.delete_all
  end

end

require 'rails_helper'

describe "Delete participations" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdls] }
  let(:path){ send "api_#{mdls}_path" }
  let(:mode){ :delete }

  let(:mdls){ "participations" }
  let(:participation){ create :participation }

  before{ participation }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Existing tags are deleted" do
    should change(Participation,:count).from(1).to(0)
    expect(response).to eq([
      'id'          => participation.id,
      'participant' => {
        'id'          => participation.article_id,
        'name'        => "factory name" },
      'event'       => {
        'id'          => participation.event_id,
        'title'       => "factory title" } ])
  end

  after do
    Participation.delete_all
    Article.delete_all
    Event.delete_all
    Universe.delete_all
  end

end

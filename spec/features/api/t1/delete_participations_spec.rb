require 'rails_helper'

describe "T1 Delete participations" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdls_name}_path" }
  let(:mdls_name){ mdl_name.pluralize }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdls_name] }
  let(:mdl){ create mdl_name }

  let(:mdl_name){ "participation" }
  let(:article){ Article.first }
  let(:event){ Event.first }

  before{ header; mdl }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Successfully" do
    should change(Participation,:count).from(1).to(0)
    expect(response).to eq([
      'id'          => mdl.id,
      'event'       => {
        'id'          => event.id,
        'title'       => "factory title" },
      'participant' => {
        'id'          => article.id,
        'name'        => "factory name" } ])
  end

  after do
    Participation.delete_all
    Event.delete_all
    Article.delete_all
    Universe.delete_all 
  end

end

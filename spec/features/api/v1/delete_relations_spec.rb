require 'rails_helper'

describe "Delete relations" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdls] }
  let(:path){ send "api_#{mdls}_path" }

  let(:mode){ :delete }
  let(:mdls){ "relations" }
  let(:relation){ create :relation } 

  before{ relation }

  subject{ ->{ driver.submit mode, path, nil }}

  it "existing steps are deleted" do
    should change(Relation,:count).from(1).to(0)
    expect(response).to eq([{
      'id'         => relation.id,
      'type'       => "Owner",
      'references' => [],
      'origin'     => {
        'id'         => relation.origin_id,
        'gender'     => 'n',
        'name'       => "factory name" },
      'target'     => {
        'id'         => relation.target_id,
        'gender'     => 'n',
        'name'       => "factory name" } }])
  end

  after do
    Relation.delete_all
    Article.delete_all
    Universe.delete_all 
  end

end

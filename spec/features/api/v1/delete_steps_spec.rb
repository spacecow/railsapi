require 'rails_helper'

describe "Delete steps" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdls] }
  let(:path){ send "api_#{mdls}_path" }

  let(:mode){ :delete }
  let(:mdls){ "steps" }
  let(:step){ create :step }

  before{ step }

  subject{ ->{ driver.submit mode, path, nil }}

  it "existing steps are deleted" do
    should change(Step,:count).from(1).to(0)
    expect(response).to eq([{
      'id'        => step.id,
      'parent_id' => step.parent_id,
      'child_id'  => step.child_id
    }])
  end

  after do
    Step.delete_all
    Event.delete_all
    Universe.delete_all
  end 

end

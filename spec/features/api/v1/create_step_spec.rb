require 'rails_helper'

describe "Create step" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:path){ send "api_#{mdl.pluralize}_path" }

  let(:mode){ :post }
  let(:params){{ step:{parent_id:parent.id, child_id:child.id }}}
  let(:mdl){ "step" }
  let(:parent){ create :event }
  let(:step){ Step.first }
  let(:child){ create :event }

  subject{ ->{ driver.submit mode, path, params }}

  it "a step is created" do
    should change(Step,:count).from(0).to(1)
    expect(response).to eq(
    { 'id'        => step.id,
      'parent_id' => parent.id,
      'child_id'  => child.id })
  end

  after do
    Step.delete_all
    Event.delete_all
    Universe.delete_all
  end

end

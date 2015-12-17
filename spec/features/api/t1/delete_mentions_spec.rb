require 'rails_helper'

describe "T1 Delete mentions" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdls_name}_path" }
  let(:mdls_name){ mdl_name.pluralize }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdls_name] }
  let(:mdl){ create mdl_name }

  let(:mdl_name){ "mention" }
  let(:origin){ Event.first }
  let(:target){ Event.last }

  before{ header; mdl }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Successfully" do
    should change(Mention,:count).from(1).to(0)
    expect(response).to eq([
      'id'      => mdl.id,
      'origin'  => {
        'id'      => origin.id,
        'title'   => "factory title" },
      'target'  => {
        'id'      => target.id,
        'title'   => "factory title" } ])
  end

  after do
    Mention.delete_all
    Event.delete_all
    Universe.delete_all
  end

end

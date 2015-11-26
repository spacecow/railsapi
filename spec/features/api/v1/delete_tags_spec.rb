require 'rails_helper'

describe "Delete tags" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdls] }
  let(:path){ send "api_#{mdls}_path" }

  let(:mode){ :delete }
  let(:mdls){ "tags" }
  let(:tag){ create :tag }

  before{ tag }

  subject{ ->{ driver.submit mode, path, nil }}

  it "existing tags are deleted" do
    should change(Tag,:count).from(1).to(0)
    expect(response).to eq([{
      'id'    => tag.id,
      'title' => 'factory title'
    }])
  end  

end

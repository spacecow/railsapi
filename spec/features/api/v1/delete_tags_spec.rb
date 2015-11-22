require 'rails_helper'

describe "Delete tags" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse page.text }

  let(:path){ api_tags_path }
  let(:tag){ create :tag }
  let(:tag_id){ tag.id }

  before{ tag }

  subject{ ->{ driver.submit :delete, path, nil }}

  it "existing tags are deleted" do
    should change(Tag,:count).from(1).to(0)
    expect(response['tags']).to eq([{
      'id'           => tag_id,
      'title'        => 'factory title'
    }])
  end  

end

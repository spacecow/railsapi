require 'rails_helper'

describe "Delete note" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdl_name] }
  let(:path){ send "api_#{mdl_name}_path", mdl.id }
  let(:mode){ :delete }
  let(:mdl_name){ mdl.class.to_s.downcase }

  let(:mdl){ create :note, text:"Everyone got killed" }

  before{ mdl }

  subject{ ->{ driver.submit mode, path, nil }}

  it "note is deleted" do
    should change(Note,:count).from(1).to(0)
    expect(response).to eq({
      'id'         => mdl.id,
      'text'       => "Everyone got killed" })
  end

  after do
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

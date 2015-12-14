require 'rails_helper'

describe "T1 Delete tags" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdls_name}_path" }
  let(:mdls_name){ mdl_name.pluralize }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdls_name] }

  let(:tag){ create mdl_name, title:"Warder" }
  let(:note_tag){ create :note_tag, tag:tag }
  let(:mdl_name){ "tag" }

  before{ header; note_tag }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Successfully" do
    should change(Tag,:count).from(1).to(0).and(
           change(NoteTag,:count).from(1).to(0))
    expect(response).to eq([
      'id'    => tag.id,
      'title' => "Warder" ])
  end

  after do
    NoteTag.delete_all
    Tag.delete_all
    Note.delete_all
  end

end

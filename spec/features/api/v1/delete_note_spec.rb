require 'rails_helper'

describe "Delete note" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:path){ send "api_#{mdl}_path", note.id }

  let(:mode){ :delete }
  let(:mdl){ "note" }
  let(:note){ create :note, text:"Everyone got killed" }

  before{ note }

  subject{ ->{ driver.submit mode, path, nil }}

  it "note is deleted" do
    should change(Note,:count).from(1).to(0)
    expect(response).to eq({
      'id'         => note.id,
      'article_id' => note.article_id,
      'text'       => "Everyone got killed",
      'references' => [],
      'tags'       => []
    })
  end

  after do
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

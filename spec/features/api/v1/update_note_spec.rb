require 'rails_helper'

describe "Update note" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:path){ send "api_#{mdl}_path", note }

  let(:mdl){ "note" }
  let(:mode){ :put }
  let(:params){{ note:{ text:"a new note" }}}
  let(:note){ create :note, text:"an old note" }

  before{ note }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should_not change(Note, :count) 
    expect(response).to eq({
      'id'          => Note.first.id,
      'article_id'  => note.article_id,
      'text'        => "a new note",
      'articles'    => [],
      'tags'        => [],
      'references'  => [] })
    expect(note.reload.text).to eq "a new note"
  end

  after do
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

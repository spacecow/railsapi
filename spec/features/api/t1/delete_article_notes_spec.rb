require 'rails_helper'

describe "Delete article notes" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdls}_path" }
  let(:mdls){ mdl.pluralize }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdls] }

  let(:mdl){ "article_note" }
  let(:article_note){ create :article_note }

  before{ header; article_note }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Successfully" do
    should change(ArticleNote,:count).from(1).to(0)
    expect(response).to eq([{
      'id'         => article_note.id,
      'article_id' => Article.first.id,
      'note_id'    => Note.first.id }])
  end

  after do
    ArticleNote.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

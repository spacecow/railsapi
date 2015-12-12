require 'rails_helper'

describe "Delete note" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdl_name] }
  let(:path){ send "api_#{mdl_name}_path", mdl.id }
  let(:mode){ :delete }

  let(:mdl_name){ "note" }
  let(:article){ create :article }
  let(:noting){ create :article_note, article:article, note:mdl }
  let(:mdl){ create mdl_name, text:"Everyone got killed" }

  before{ noting }

  subject{ ->{ driver.submit mode, path, nil }}

  it "note is deleted" do
    should change(Note,:count).from(1).to(0).and(
           change(ArticleNote,:count).from(1).to(0))
    expect(response).to eq({
      'id'         => mdl.id,
      'text'       => "Everyone got killed" })
  end

  after do
    ArticleNote.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

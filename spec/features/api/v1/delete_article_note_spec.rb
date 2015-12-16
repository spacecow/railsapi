require 'rails_helper'

describe "Delete article note" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdl_name}_path", mdl.id }
  let(:response){ JSON.parse(page.text)[mdl_name] }

  let(:mdl_name){ "note" }
  let(:article){ create :article, name:"a name" }
  let(:noting){ create :article_note, article:article, note:mdl }
  let(:mdl){ create mdl_name, text:"Everyone got killed" }

  before{ noting }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Successfully" do
    should change(Note,:count).from(1).to(0).and(
           change(ArticleNote,:count).from(1).to(0))
    expect(response).to eq(
      'id'      => mdl.id,
      'text'    => "Everyone got killed",
      'article' => {
        'id'      => article.id,
        'name'    => "a name" })
  end

  after do
    ArticleNote.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

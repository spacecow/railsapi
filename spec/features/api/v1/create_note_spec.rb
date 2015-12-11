require 'rails_helper'

describe "Create note" do

  let(:response){ JSON.parse(page.text)[mdl_name] }
  let(:driver){ Capybara.current_session.driver }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:mode){ :post }

  let(:article){ create :article }
  let(:mdl_name){ "note" }
  let(:mdl){ Note.first }
  let(:params){{ mdl_name => { article_id:article.id, text:"a note" }}}

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(Note,:count).from(0).to(1).and(
           change(ArticleNote,:count).from(0).to(1))
    expect(response).to eq({
      'id'          => Note.first.id,
      'article_id'  => article.id,
      'text'        => "a note" })
  end

  after do
    ArticleNote.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

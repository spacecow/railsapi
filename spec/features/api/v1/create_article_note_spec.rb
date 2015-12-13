require 'rails_helper'

describe "Create article note" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.v1' }
  let(:response){ JSON.parse(page.text)[mdl_name] }
  let(:mdl){ mdl_name.camelize.constantize.first }

  let(:mdl_name){ "note" }
  let(:article){ create :article, name:"a name" }
  let(:params){{ mdl_name => { article_id:article.id, text:"a note" }}}

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(Note,:count).from(0).to(1).and(
           change(ArticleNote,:count).from(0).to(1))
    expect(response).to eq({
      'id'      => Note.first.id,
      'text'    => "a note",
      'article' => {
        'id'      => article.id,
        'name'    => "a name" }})
    expect(mdl.text).to eq "a note"
    expect(mdl.article_id).to eq article.id
    expect(mdl.event_id).to be nil 
  end

  after do
    ArticleNote.delete_all
    Note.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

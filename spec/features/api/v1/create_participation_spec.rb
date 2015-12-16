require 'rails_helper'

describe "Create participation" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.v1' }
  let(:response){ JSON.parse(page.text)[mdl_name] }

  let(:mdl_name){ "participation" }
  let(:params){{ mdl_name => { event_id:event.id, participant_id:article.id }}}
  let(:event){ create :event, title:"a title" }
  let(:article){ create :article, name:"a name" }
  let(:mdl){ Participation.first }

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "a participation is created" do
    should change(Participation,:count).from(0).to(1)
    expect(response).to eq(
      'id'          => mdl.id,
      'event'       => {
        'id'          => event.id,
        'title'       => "a title" },
      'participant' => {
        'id'          => article.id,
        'name'        => "a name"} )
    expect(mdl.event_id).to be event.id
    expect(mdl.article_id).to be article.id
  end

  after do
    Participation.delete_all
    Event.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

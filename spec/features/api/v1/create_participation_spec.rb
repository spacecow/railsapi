require 'rails_helper'

describe "Create participation" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:path){ send "api_#{mdl.pluralize}_path" }

  let(:mode){ :post }
  let(:params){{ participation:{ event_id:event.id, article_id:article.id }}}
  let(:mdl){ "participation" }

  let(:participation){ Participation.last }
  let(:event){ create :event, title:"a title" }
  let(:article){ create :article, name:"a name" }

  subject{ ->{ driver.submit mode, path, params }}

  it "a participation is created" do
    should change(Participation,:count).from(0).to(1)
    expect(response).to eq(
      'id'          => participation.id,
      'event'       => {
        'id'          => event.id,
        'title'       => "a title" },
      'participant' => {
        'id'          => article.id,
        'name'        => "a name"} )
    expect(participation.event_id).to be event.id
    expect(participation.article_id).to be article.id
  end

  after do
    Participation.delete_all
    Event.delete_all
    Article.delete_all
    Universe.delete_all
  end

end

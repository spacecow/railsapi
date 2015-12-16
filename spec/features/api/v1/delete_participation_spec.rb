require 'rails_helper'

describe "Delete participation" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :delete }
  let(:path){ send "api_#{mdl_name}_path", mdl.id }
  let(:mdl){ create mdl_name, event:event, participant:article }
  let(:response){ JSON.parse(page.text)[mdl_name] }

  let(:mdl_name){ "participation" }
  let(:event){ create :event, title:"a title" }
  let(:article){ create :article, name:"a name" }

  before{ mdl }

  subject{ ->{ driver.submit mode, path, nil }}

  it "Successfully" do
    should change(Participation,:count).from(1).to(0)
    expect(response).to eq(
      'id'          => mdl.id,
      'event'       => {
        'id'          => event.id,
        'title'       => "a title" },
      'participant' => {
        'id'          => article.id,
        'name'        => "a name" } )
    expect(mdl.event_id).to be event.id
    expect(mdl.article_id).to be article.id
  end

  after do
    Participation.delete_all
    Article.delete_all
    Event.delete_all
    Universe.delete_all
  end

end

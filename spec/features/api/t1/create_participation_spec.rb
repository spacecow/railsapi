require 'rails_helper'

describe "T1 Create participation" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:response){ JSON.parse(page.text)[mdl_name] }
  let(:mdl){ mdl_name.camelize.constantize.first }

  let(:mdl_name){ "participation" }
  let(:params){{}}
  let(:event){ Event.first }
  let(:article){ Article.first }
  

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(Participation,:count).from(0).to(1)
    expect(response).to eq(
      'id'          => mdl.id,
      'event'       => {
        'id'          => event.id,
        'title'       => "factory title" },
      'participant' => {
        'id'          => article.id,
        'name'        => "factory name" } )
  end

  after do
    Participation.delete_all
    Event.delete_all
    Article.delete_all
    Universe.delete_all 
  end

end

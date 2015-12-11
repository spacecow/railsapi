require 'rails_helper'

describe "T1 Create article note" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :post }
  let(:path){ send "api_#{mdl_name.pluralize}_path" }
  let(:header){ driver.header 'Accept', 'application/vnd.example.t1' }
  let(:mdl){ mdl_name.camelize.constantize.first }
  let(:response){ JSON.parse(page.text)[mdl_name] }

  let(:mdl_name){ "article_note" }
  let(:params){{}}

  before{ header }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should change(ArticleNote,:count).from(0).to(1)
    expect(response).to eq({
      'id' => mdl.id })
  end

  after do
    ArticleNote.delete_all
  end

end

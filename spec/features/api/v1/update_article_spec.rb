require 'rails_helper'

describe "Update article" do

  let(:driver){ Capybara.current_session.driver }
  let(:mode){ :put }
  let(:path){ send "api_#{mdl_name}_path", article  }
  let(:response){ JSON.parse(page.text)[mdl_name] }

  let(:mdl_name){ "article" }
  let(:params){{ mdl_name => { name:"updated name", gender:'m' }}}
  let(:article){ create mdl_name, name:"old name", gender:'f' }

  before{ article }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should_not change(Article,:count) 
    expect(response).to eq({
      'id'                => article.id,
      'name'              => "updated name",
      'universe_id'       => article.universe_id,
      'type'              => "Character",
      'gender'            => 'm',
      'events'            => [],
      'notes'             => [],
      'citations'         => [],
      'inverse_citations' => [],
      'tags'              => [] })
    article.reload
    expect(article.name).to eq "updated name"
    expect(article.gender).to eq "m"
  end

  after do
    Article.delete_all
    Universe.delete_all
  end

end

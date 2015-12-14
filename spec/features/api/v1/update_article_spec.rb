require 'rails_helper'

describe "Update article" do

  let(:driver){ Capybara.current_session.driver }
  let(:response){ JSON.parse(page.text)[mdl] }
  let(:path){ send "api_#{mdl}_path", article  }

  let(:mdl){ "article" }
  let(:mode){ :put }
  let(:params){{ article:{ name:"updated name", gender:'m' }}}
  let(:article){ create :article, name:"old name", gender:'f' }

  before{ article }

  subject{ ->{ driver.submit mode, path, params }}

  it "Successfully" do
    should_not change(Article, :count) 
    expect(response).to eq({
      'id'          => article.id,
      'name'        => "updated name",
      'universe_id' => article.universe_id,
      'type'        => "Character",
      'gender'      => 'm',
      'events'      => [],
      'notes'       => [],
      'tags'        => []
    })
    expect(Article.first.name).to eq "updated name"
    expect(Article.first.gender).to eq "m"
  end

  after do
    Article.delete_all
    Universe.delete_all
  end

end

require 'rails_helper'

describe "Delete articles" do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :delete, path, nil }
  let(:response){ JSON.parse page.text }

  let(:path){ api_articles_path }
  let(:universe){ article.universe }
  let(:universe_id){ universe.id }
  let(:article){ create :article, name:'Kelsier' }
  let(:article_id){ article.id }

  it 'existing articles are deleted' do
    article
    expect{ function }.to change(Article,:count).from(1).to(0)
    expect(response['articles']).to eq([{
      'id'          => article_id,
      'universe_id' => universe_id,
      'name'        => 'Kelsier',
      'type'        => 'Character'
    }])
  end

  after do
    Article.delete_all
    Universe.delete_all
  end

end

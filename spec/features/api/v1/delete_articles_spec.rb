require 'rails_helper'

describe 'Delete articles' do

  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :delete, api_articles_path, nil }
  let(:response){ JSON.parse page.text }

  context 'success' do
    it 'all articles are deleted' do
      universe = create :universe
      article = create :article, name:'Kelsier', universe:universe
      expect(Article.count).to be 1
      function
      expect(Article.count).to be 0
      expect(response['articles']).to eq([{
        'id'          => article.id,
        'name'        => 'Kelsier',
        'type'        => 'Character',
        'universe_id' => universe.id }])
    end
  end

  after{ Universe.delete_all }

end

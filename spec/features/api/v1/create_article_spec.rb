require 'rails_helper'

describe 'Create Article' do

  let(:universe){ create :universe }
  let(:params){ {article:{name:'Kelsier', universe_id:universe.id}} }
  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :post, api_articles_path, params }
  let(:body){ JSON.parse page.text }

  context "a universe is selected" do
    it "" do
      expect(Article.count).to be 0
      function
      expect(Article.count).to be 1
      expect(body["article"]).to eq({
        "id" => Article.first.id,
        "name" => 'Kelsier',
        "universe_id" => universe.id })
    end
  end

  pending "no universe is selected"

  after do
    Article.delete_all
    Universe.delete_all
  end

end

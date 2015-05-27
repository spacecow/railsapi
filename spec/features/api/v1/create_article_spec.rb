require 'rails_helper'

describe 'Create Article' do

  let(:universe){ create :universe }
  let(:universe_id){ universe.id }
  let(:name){ 'Kelsier' }
  let(:params){ {article:{name:name, type:'Character', universe_id:universe_id}} }
  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :post, api_articles_path, params }
  let(:body){ JSON.parse page.text }

  context "a universe is selected" do
    it "" do
      expect(Article.count).to be 0
      function
      expect(Article.count).to be 1
      expect(body["article"]).to eq({
        'id'          => Article.first.id,
        'name'        => 'Kelsier',
        'type'        => 'Character',
        'universe_id' => universe.id })
    end
  end

  context "no universe is selected" do
    let(:universe_id){ nil }
    it "" do
      expect(Article.count).to be 0
      function
      expect(Article.count).to be 0
      expect(body).to have_key 'error'
      expect(body['class']).to eq ActiveRecord::RecordNotFound.to_s
    end
  end

  context "name is blank" do
    let(:name){ '' }
    it "" do
      expect(Article.count).to be 0
      function
      expect(Article.count).to be 0
      expect(body['article']['name']).to eq 'cannot be blank' 
    end
  end

  after do
    Article.delete_all
    Universe.delete_all
  end

end

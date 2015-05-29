require 'rails_helper'

describe 'Create article' do

  let(:universe){ create :universe }
  let(:universe_id){ universe.id }
  let(:name){ 'Kelsier' }
  let(:type){ 'Character' }
  let(:params){ {article:{name:name, type:type, universe_id:universe_id}} }
  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :post, api_articles_path, params }
  let(:body){ JSON.parse page.text }

  context "article is valid" do
    it "an article is created" do
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
    it "article is not created" do
      expect(Article.count).to be 0
      function
      expect(Article.count).to be 0
      expect(body['universe']['id']).to eq 'is not found' 
    end
  end

  context "a non-existing universe is selected" do
    let(:universe_id){ -1 }
    it "article is not created" do
      expect(Article.count).to be 0
      function
      expect(Article.count).to be 0
      expect(body['universe']['id']).to eq 'is not found' 
    end
  end

  context "name is blank" do
    let(:name){ '' }
    it "article is not created" do
      expect(Article.count).to be 0
      function
      expect(Article.count).to be 0
      expect(body['article']['name']).to eq 'cannot be blank' 
    end
  end

  context "type is invalid" do
    let(:type){ 'Superman' }
    it "article is not created" do
      expect(Article.count).to be 0
      function
      expect(Article.count).to be 0
      expect(body['article']['type']).to eq 'is invalid' 
    end
  end

  after do
    Article.delete_all
    Universe.delete_all
  end

end

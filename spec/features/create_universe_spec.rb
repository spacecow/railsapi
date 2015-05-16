require 'rails_helper'

describe 'Create universe' do
  let(:params){{ title:'Malazan' }}
  let(:driver){ Capybara.current_session.driver }
  let(:function){ driver.submit :post, universes_path, params }
  let(:body){ JSON.parse page.text }

  context "universe is valid" do
    it "creates a universe" do
      expect(Universe.count).to be 0
      function
      expect(Universe.count).to be 1
      expect(body).to eq({
        "id" => Universe.first.id,
        "title" => 'Malazan' })
    end
  end
  
  context "universe is invalid" do
    let(:params){ {} }
    it "universe is not created" do
      expect(Universe.count).to be 0
      function
      expect(Universe.count).to be 0
      expect(body).to have_key 'error'
    end
  end

  after{ Universe.delete_all }

end
